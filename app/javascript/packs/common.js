import { Modal } from 'bootstrap'

(() => {
    'use strict'

    const getStoredTheme = () => localStorage.getItem('theme')
    const setStoredTheme = theme => localStorage.setItem('theme', theme)

    const getPreferredTheme = () => {
        const storedTheme = getStoredTheme()
        if (storedTheme) {
            return storedTheme
        }

        return window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light'
    }

    const setTheme = theme => {
        if(theme === 'auto') {
            if (window.matchMedia('(prefers-color-scheme: dark)').matches) {
                document.documentElement.setAttribute('data-bs-theme', 'dark');
            } else {
                document.documentElement.setAttribute('data-bs-theme', 'light');
            }
        } else {
            document.documentElement.setAttribute('data-bs-theme',theme);
        }
    }

    setTheme(getPreferredTheme())

    const showActiveTheme = (theme, focus = false) => {
        const themeSwitcher = document.querySelector('#bd-theme')

        if (!themeSwitcher) {
            return
        }

        const themeSwitcherText = document.querySelector('#bd-theme-text')
        const activeThemeIcon = document.querySelector('.theme-icon-active use')
        const btnToActive = document.querySelector(`[data-bs-theme-value="${theme}"]`)
        const svgOfActiveBtn = btnToActive.querySelector('svg use').getAttribute('href')

        document.querySelectorAll('[data-bs-theme-value]').forEach(element => {
            element.classList.remove('active')
            element.setAttribute('aria-pressed', 'false')
        })

        btnToActive.classList.add('active')
        btnToActive.setAttribute('aria-pressed', 'true')
        activeThemeIcon.setAttribute('href', svgOfActiveBtn)
        const themeSwitcherLabel = `${themeSwitcherText.textContent} (${btnToActive.dataset.bsThemeValue})`
        themeSwitcher.setAttribute('aria-label', themeSwitcherLabel)

        if (focus) {
            themeSwitcher.focus()
        }
    }

    window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', () => {
        const storedTheme = getStoredTheme()
        if (storedTheme !== 'light' && storedTheme !== 'dark') {
            setTheme(getPreferredTheme())
        }
    })

    window.addEventListener('DOMContentLoaded', () => {
        showActiveTheme(getPreferredTheme())

        document.querySelectorAll('[data-bs-theme-value]')
            .forEach(toggle => {
                toggle.addEventListener('click', () => {
                    const theme = toggle.getAttribute('data-bs-theme-value')
                    setStoredTheme(theme)
                    setTheme(theme)
                    showActiveTheme(theme, true)
                })
            })
    })
})()


$(function () {
    $('.btn-modal').click(btn_modal_click);

    function btn_modal_click(event) {
        event.preventDefault();

        $('#myModal').removeData("modal");
        if ($(this).attr('href').indexOf('?') == '-1') {
            var url = $(this).attr('href') + '?popup=true';
        } else {
            var url = $(this).attr('href') + '&popup=true';
        }

        $('#myModal').load(url, function () {
            let myModal = new Modal(document.getElementById('myModal'));
            myModal.show();
        });
    }


    function pageselectCallback(page_index, jq) {
        if ($(jq).data("load") == true)
            getList(page_index, jq);
        else
            $(jq).data("load", true);

        return false;
    }

    function initPagination(num_entries, items_per_page, current_page) {
        if(!current_page) {
            var current_page=0;
        }

        if(num_entries<=items_per_page) {
            return false;
        }

        $(".sl_pagination").pagination(num_entries, {
            current_page : current_page,
            num_edge_entries : 2,
            num_display_entries : 8,
            callback : pageselectCallback,
            items_per_page : items_per_page
        });
        return false;
    }
});