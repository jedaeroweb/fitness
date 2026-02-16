import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["fileInput"]

    open() {
        this.fileInputTarget.click()
    }

    submit() {
        if (this.fileInputTarget.files.length === 0) return

        const form = this.fileInputTarget.closest("form")
        const formData = new FormData(form)

        fetch(form.action, {
            method: form.method || "POST",
            body: formData,
            headers: {
                "X-Requested-With": "XMLHttpRequest",
                "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content
            }
        })
            .then(response => response.text())
            .then(html => {
                Turbo.renderStreamMessage(html)
            })
            .catch(error => {
                console.error("upload failed", error)
            })
    }
}
