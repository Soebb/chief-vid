# ChiefVideo

Simple website for hosted videos.

## Developing

### Native

#### Simple development HTTP server

Create a `video` directory, change into it, and run:

```bash
python3 -m http.server
```

#### Simple Flask server

Install the requirements in the `app` directory:

```bash
pip3 install -r requirements.txt
python3 -m flask run
```

## Deploying to Render

This repository includes a Render Blueprint in `render.yaml`. It deploys the Flask app as a single Python web service; it does not run the Docker Compose stack or Nginx.

### Create the service

1. Sign in to Render and choose **New → Blueprint**.
2. Connect the GitHub repository `Soebb/chief-vid` and select the `Master` branch.
3. Render reads `render.yaml`. Before creating the service, provide a value for the required `LOGIN_PASSWORD` environment variable when prompted.
4. Deploy the service. Render generates `SECRET_KEY` automatically.

The Render service starts Gunicorn on Render's assigned `PORT`. Flask serves both the website and video files, so a separate Nginx service is not needed for this deployment.

### How videos reach the site

For this Render setup, videos are read from the repository's `videos/` directory at deploy time. The configured path is `VIDEO_PATH=../videos` because the app runs from the `app/` directory. Flask serves video bytes at `/media/<category>/<filename>`.

Keep the folder structure:

```text
videos/
└── Demo/
    └── sample.mp4
```

When you add or replace a video in GitHub on the `Master` branch, Render's automatic deploy rebuilds the service with that repository version, and the updated video set becomes available after deployment finishes.

**Important limitations:** Render's free web service has an ephemeral filesystem and can spin down when idle. This Git-based approach is suitable for small demo files, but it is not persistent upload storage and is not recommended for a large video library. Files added only to the running service can disappear on restart or redeploy. For a growing library, use object storage (such as an S3-compatible bucket) or a Render persistent disk on a paid service, then configure the app to read from that storage. GitHub should not be used as a long-term host for large video files.

## Deploying with Docker Compose

The Compose setup runs the Flask/Gunicorn website and an Nginx web server:

- **Flask** reads the video directory, calculates file metadata, and renders the website.
- **Nginx** serves the actual video bytes from the same shared storage and forwards the other requests to Flask.
- Both containers mount the same Docker volume at `/videos`. Nginx mounts it read-only.

### Required environment variables

Set these variables in the deployment platform before starting the stack:

- `SECRET_KEY`: a long, random secret used by Flask sessions.
- `LOGIN_PASSWORD`: the password used to sign in to the website.

Do not commit real secrets to Git.

### Video storage

The Compose file declares a persistent named volume called `video-data`. Put the video folders in this volume, keeping the structure below:

```text
/videos/
├── Category1/
│   ├── Video1.mp4
│   └── Video2.mp4
└── Category2/
    └── Video1.mp4
```

The volume must be persistent on the hosting platform. If the platform does not support persistent named Docker volumes or does not allow files to be added to them, configure its persistent storage feature and mount that storage at `/videos` in both the `app` and `nginx` services instead. Do not put large video files in the application image or commit them to Git.

### Request routing

- Website pages (including `/videos` and `/videos/<category>/<filename>`) are sent by Nginx to Flask.
- Video files are served by Nginx under `/media/<category>/<filename>`.
- `VIDEO_PATH=/videos` tells Flask where to inspect files.
- `VIDEO_URL=/media` tells the video page where the browser can fetch the actual file. This separate URL prefix avoids conflicting with Flask's existing `/videos` page routes.

Nginx listens on port 80 in the container. The deployment platform must route public HTTP traffic to the Nginx service on container port 80. If the platform requires a different internal port or a different routing configuration, adjust the `nginx` service accordingly.

### Local Compose run

For a local test, create a `.env` file in the repository root with:

```dotenv
SECRET_KEY=replace-with-a-long-random-value
LOGIN_PASSWORD=choose-a-strong-password
```

Then start the stack:

```bash
docker compose up --build -d
```

Add video files to the persistent `video-data` volume before expecting them to appear in the website. The `.env` file is for local use only; configure the same variables as deployment secrets on your hosting platform.

## Directory

The video directory must be structured as follows:

```text
. // video root
|- Category1
|  |- Video1
|  |- Video2
|- Category2
|  |- Video1
|  |- Video2
|- ...
```

## Environment Variables

- `VIDEO_PATH`: absolute path to the video directory. The Compose deployment sets it to `/videos`.
- `VIDEO_URL`: base URL used by the browser to fetch video files. The Compose deployment sets it to `/media`, served by Nginx.
- `SECRET_KEY`: required by Flask to use secure sessions.
- `LOGIN_PASSWORD`: password for the website.
- `VIDEO_USERNAME` and `VIDEO_PASSWORD`: optional HTTP basic-auth credentials for a separate video server. They are not needed for the included Nginx setup.

## Roadmap

- [x] better authentication (not just basic http)
- [x] search functionality
- [ ] option to setup without a website password
- [ ] Live streaming
- [ ] video upload (in website)
- [ ] configuration files (to possibly exclude some files or set other information)
- [ ] allowing to use a remote video directory
- [x] show videolength (using ffmpeg - ffprobe)
- [ ] converter for new video files (as not all video formats are supported in every browser)
- [x] update design
