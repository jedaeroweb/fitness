import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="user-select"
export default class extends Controller {
    static targets = ["userList"]

    selectUsers(event) {
        event.preventDefault()

        // 선택된 input 가져오기 (radio 또는 checkbox)
        const selectedInputs = this.userListTarget.querySelectorAll('input[name="id[]"]:checked')

        if (selectedInputs.length === 0) {
            alert("선택된 사용자가 없습니다.")
            return
        }

        // 기존 user hidden 초기화
        const existing = document.querySelectorAll('input[name="user[]"]')
        existing.forEach(el => el.remove())

        selectedInputs.forEach(input => {
            const hidden = document.createElement("input")
            hidden.type = "hidden"
            hidden.name = "user[]"
            hidden.value = input.value

            const userLayer= document.querySelector("#select_user_layer")
            userLayer.appendChild(hidden)
        })

        // 모달 닫기 (Bootstrap 5 기준)
        const modalEl = this.element.closest(".modal")
        const closeBtn = modalEl.querySelector('[data-bs-dismiss="modal"]')

        if (closeBtn) {
            closeBtn.click()
        }
    }
}