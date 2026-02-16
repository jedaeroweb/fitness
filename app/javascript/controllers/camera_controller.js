import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [
        "video",
        "canvas",
        "photo",
        "snapButton",
        "saveButton",
        "resumeButton"
    ]

    connect() {
        if (!navigator.mediaDevices || !navigator.mediaDevices.getUserMedia) {
            alert("카메라장치에 접근할 수 없습니다.")
            window.close()
            return
        }

        this.context = this.canvasTarget.getContext("2d")
        this.videoInterval = null
        this.imageData = null

        navigator.mediaDevices.getUserMedia({ video: true })
            .then(stream => {
                try {
                    this.videoTarget.srcObject = stream
                } catch (error) {
                    this.videoTarget.src = URL.createObjectURL(stream)
                }

                this.videoTarget.onloadedmetadata = () => {
                    this.videoTarget.play()
                }
            })
            .catch(err => alert(err))

        this.videoRun()
    }

    drawVideo = () => {
        if (!this.context) return
        this.context.drawImage(this.videoTarget, 0, 0, 372, 372)
    }

    videoRun() {
        this.enable(this.snapButtonTarget)
        this.disable(this.saveButtonTarget)
        this.disable(this.resumeButtonTarget)

        clearInterval(this.videoInterval)
        this.videoInterval = setInterval(this.drawVideo, 1000 / 30)
    }

    snap() {
        clearInterval(this.videoInterval)
        this.imageData = this.canvasTarget.toDataURL()

        this.disable(this.snapButtonTarget)
        this.enable(this.saveButtonTarget, true)
        this.enable(this.resumeButtonTarget)
    }

    resume() {
        this.videoRun()
    }

    save() {
        const r_id = document.getElementById("v_id")?.value
        const v_type = document.getElementById("v_type")?.value

        let r_url, delete_url

        switch (v_type) {
            case "employees":
                r_url = `/employee-pictures/update-photo/${r_id}`
                delete_url = "/employee-pictures/delete"
                break
            default:
                r_url = `/user-pictures/update-photo/${r_id}`
                delete_url = "/user-pictures/delete"
        }

        fetch(r_url, {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
                "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
            },
            body: JSON.stringify({
                data_image: this.imageData,
                format: "json"
            })
        })
            .then(res => res.json())
            .then(data => {
                if (data.result === "success") {
                    if (window.opener) {
                        window.opener.showPhoto(decodeURIComponent(data.photo))
                        window.close()
                    }
                } else {
                    alert(data.message)
                }
            })
    }

    enable(el, primary = false) {
        el.disabled = false
        if (primary) {
            el.classList.remove("btn-secondary")
            el.classList.add("btn-primary")
        }
    }

    disable(el) {
        el.disabled = true
        el.classList.remove("btn-primary")
        el.classList.add("btn-secondary")
    }
}
