
const onDOMReady = (callback) => {
    if (document.readyState === "loading")
        document.addEventListener("DOMContentLoaded", callback)
    else
        callback()
}

const setupVideo = (video) => {
    const hlsEl  = video.querySelector("source[src$=\".m3u8\"], source[type=\"application/vnd.apple.mpegurl\"]")
    const mp4El  = video.querySelector("source[type^=\"video/mp4\"]")
    const hlsUrl = hlsEl ? hlsEl.src : null
    const mp4Url = mp4El ? mp4El.src : null
    const poster = video.getAttribute("poster")

    while (video.firstChild)
        video.removeChild(video.firstChild)
    video.removeAttribute("src")
    video.load()

    const attachPlyr = () => {
        video.loop  = true
        video.muted = true
        new Plyr(video, {
            iconUrl: "libs/plyr.svg",
            displayDuration: true,
            autoplay: true,
            muted: true,
            loop: { active: true },
            storage: { enabled: false, key: "plyr" },
            tooltips: {
                controls: true,
                seek: false
            },
            settings: [],
            controls: [
                "play",
                "progress",
                "fullscreen"
            ]
        })
        video.play()
    }

    if (mp4Url) {
        video.src = mp4Url
        attachPlyr()
    }
    else if (Hls.isSupported() && hlsUrl) {
        const hls = new Hls({
            lowLatencyMode:              false,
            liveDurationInfinity:        true,
            maxLiveSyncPlaybackRate:     2.0,
            maxBufferLength:             20,
            backBufferLength:            Infinity,
            liveSyncDuration:            8,
            liveMaxLatencyDuration:      12,
            initialLiveManifestSize:     1
        })
        hls.on(Hls.Events.ERROR, (ev, data) => {
            if (data.type === Hls.ErrorTypes.MEDIA_ERROR) {
                setTimeout(() => {
                    hls.recoverMediaError()
                }, 500)
            }
            if (data.fatal) {
                hls.destroy()
                throw new Error("fatal error on HLS")
            }
        })
        hls.on(Hls.Events.MANIFEST_PARSED, attachPlyr)
        hls.loadSource(hlsUrl)
        hls.attachMedia(video)
    }
    else if (hlsUrl && video.canPlayType("application/vnd.apple.mpegurl")) {
        video.src = hlsUrl
        attachPlyr()
    }
}

