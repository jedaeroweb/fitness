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
        if (!this.hasVideoTarget || !this.hasCanvasTarget) return

        this.canvasContext = this.canvasTarget.getContext("2d")
        this.videoInterval = null
        this.imageData = null

        const modal = this.element.closest(".modal")

        if (modal) {
            modal.addEventListener("hidden.bs.modal", () => {
                this.stopCamera()
            })
        }

        this.startCamera()
    }

    disconnect() {
        this.stopCamera()
    }

    startCamera() {
        if (!navigator.mediaDevices?.getUserMedia) {
            alert("카메라장치에 접근할 수 없습니다.")
            return
        }

        navigator.mediaDevices.getUserMedia({ video: true })
            .then(stream => {
                this.videoTarget.srcObject = stream

                this.videoTarget.onloadedmetadata = () => {
                    this.videoTarget.play()

                    // video 크기에 맞게 canvas 조정
                    this.canvasTarget.width = this.videoTarget.videoWidth
                    this.canvasTarget.height = this.videoTarget.videoHeight

                    this.videoRun()
                }
            })
            .catch(err => alert(err))
    }

    stopCamera = () => {
        if (this.videoTarget?.srcObject) {
            this.videoTarget.srcObject.getTracks().forEach(track => track.stop())
            this.videoTarget.srcObject = null
        }
        clearInterval(this.videoInterval)
    }

    drawVideo = () => {
        if (!this.canvasContext) return
        this.canvasContext.drawImage(
            this.videoTarget,
            0,
            0,
            this.canvasTarget.width,
            this.canvasTarget.height
        )
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

        let r_url
        let delete_url
        let body

        switch (v_type) {
            case "employee":
                r_url = `/admin/admin_pictures/create_b64`
                delete_url = "/admin/admin_pictures/delete"
                body= {
                    admin_id: r_id,
                    data_image: this.imageData,
                    format: "json"
                }
                break
            default:
                r_url = `/admin/user_pictures/create_b64`
                delete_url = "/admin/user_pictures/delete"
                body= {
                    user_id: r_id,
                    data_image: this.imageData,
                    format: "json"
                }
        }

        fetch(r_url, {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
                "Accept": "text/vnd.turbo-stream.html",
                "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
            },
            body: JSON.stringify(body)
        })
            .then(response => response.text())
            .then(html => {
                Turbo.renderStreamMessage(html)

                this.stopCamera()

                const modalEl = this.element.closest(".modal")
                const closeBtn = modalEl.querySelector('[data-bs-dismiss="modal"]')

                if (closeBtn) {
                    closeBtn.click()
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
