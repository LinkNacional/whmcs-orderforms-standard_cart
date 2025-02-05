window.addEventListener('DOMContentLoaded', (event) => {
  const link = document.createElement('link')
  link.href = 'templates/twenty-one-child/css/intlTelInput/intlTelInput.css'
  link.type = 'text/css'
  link.rel = 'stylesheet'
  link.media = 'screen,print'

  document.getElementsByTagName('head')[0].appendChild(link)

  const IS_DEV_ENV = true
  const CUSTOM_FIELDS_IDS = {
    cpf: IS_DEV_ENV ? 2 : 2,
    cnpj: IS_DEV_ENV ? 3 : 5,
    whatsapp: IS_DEV_ENV ? 1 : 15,
    companyLegalName: IS_DEV_ENV ? 10 : 4,
    gender: IS_DEV_ENV ? 12 : 7,
    birthDate: IS_DEV_ENV ? 4 : 8,
    stateRegistration: IS_DEV_ENV ? 9 : 6,
    isLegalPerson: IS_DEV_ENV ? 5 : 64,
    anotherGender: IS_DEV_ENV ? 13 : 65,
    nif: IS_DEV_ENV ? 6 : 66,
    legacyIsLegalPerson: IS_DEV_ENV ? 11 : 1,
    municipalReg: IS_DEV_ENV ? 8 : 55,
    addressComplement: IS_DEV_ENV ? 7 : 68
  }

  const INTL_TEL_INPUT_SETTINGS = {
    separateDialCode: true,
    initialCountry: 'BR',
    preferredCountries: ['BR', 'PT', 'MZ', 'US'],
    utilsScript: 'templates/twenty-one-child/js/libs/intlTelInput/utils.min.js',
    formatOnDisplay: false,
    nationalMode: false,
    autoInsertDialCode: true,
    autoPlaceholder: 'aggressive',
    customPlaceholder: function (selectedCountryPlaceholder, selectedCountryData) {
      return selectedCountryData.dialCode === '55' ? '(00) 0 0000-0000' : selectedCountryPlaceholder
    }
  }

  const inputPhoneNumber = document.querySelector('#inputPhone')

  const registerClientForm = document.querySelector('#frmCheckout')

  const submitBtn = document.querySelector('#btnCompleteOrder')
  const fiscalDataCont = document.querySelector('#taxDataCard')

  const inputMarketingOptin = null
  const ptFiscalDataCont = document.getElementById('pt-fiscal-data-cont')
  const brFiscalDataCont = document.getElementById('br-fiscal-data-cont')
  const inputCnpj = document.querySelector('#inputCNPJ')
  const inputCpf = document.querySelector('#inputCPF')
  const inputNif = document.querySelector('#inputNIF')
  const inputIsLegalPerson = document.getElementById('isLegalPerson')
  const inputIsLegalPersonCont = inputIsLegalPerson.parentElement.children[1]
  const hiddenCnpjTradeName = null
  const hiddenCnpjLegalName = null
  // const inputBirthDate = document.querySelector('#customfield' + CUSTOM_FIELDS_IDS.birthDate)
  const inputFullname = document.querySelector('#inputFullname')
  const inputEmail = document.querySelector('#inputEmail')
  const inputPostcode = document.querySelector('#inputPostcode')
  const inputCountry = document.querySelector('#inputCountry')
  const inputNewPassword1 = document.querySelector('#inputNewPassword1')
  const inputNewPassword2 = document.querySelector('#inputNewPassword2')
  const inputStreet = document.querySelector('#inputAddress1')
  const inputDistrict = document.querySelector('#inputAddress2')
  const inputCity = document.querySelector('#inputCity')
  const inputAddressComponent = document.getElementById('inputAddressComponent')

  const inputState = () => {
    const stateInput = document.querySelector('#stateinput')

    if (stateInput && stateInput.style.display !== 'none') {
      return document.querySelector('#stateinput')
    }

    return document.querySelector('#stateselect')
  }

  const inputBirthDateDay = document.getElementById('inputBirthDateDay')
  const inputBirthDateMonth = document.getElementById('inputBirthDateMonth')
  const inputBirthDateYear = document.getElementById('inputBirthDateYear')
  const inputNumber = document.querySelector('#inputNumber')
  const inputPhoneIsWhatsapp = document.getElementById('customPhoneInput')

  const formGroupCpf = inputCpf.parentElement.parentElement
  // const formGroupBirthDate = inputBirthDate.parentElement.parentElement
  const formGroupCnpj = inputCnpj.parentElement.parentElement
  const formGroupNif = inputNif.parentElement.parentElement

  const formGroupIsLegalPerson = inputIsLegalPerson.parentElement.parentElement

  formGroupIsLegalPerson.style.cssText = 'display: flex; align - items: center;'
  formGroupIsLegalPerson.children[0].style.cssText = 'margin-bottom: 0px; margin-right: 10px;'
  formGroupIsLegalPerson.classList.add('d-flex', 'align-items-center')

  const posCpfReal = document.querySelector('#cpfRealPos')
  const posIsLegalPerson = document.querySelector('#isLegalPersonPos')
  const posCnpj = document.querySelector('#cnpjPos')
  const posNif = document.querySelector('#nif-pos')
  // const posBirthDate = document.querySelector('#birthDatePos')

  // Move custom fields to the correct positions on screen.
  posCpfReal.append(formGroupCpf)
  posCnpj.append(formGroupCnpj)
  posIsLegalPerson.append(formGroupIsLegalPerson)
  posNif.append(formGroupNif)
  // posBirthDate.append(formGroupBirthDate)

  function update_cached_form_value(items) {
    items.forEach(input => {
      const element = input[0]

      const inputName = element.name
      const newValue = input[1]

      localStorage.setItem(inputName, newValue)
    })
  }

  function setup_form_cache_listener(inputs) {
    inputs.forEach(input => {
      if (!input) { return }
      const event = input.tagName === 'SELECT' ? 'change' : 'keyup'
      const inputName = input.name

      const cachedValue = localStorage.getItem(inputName)

      if (input.type === 'checkbox') {
        input.checked = cachedValue === 'true' ? true : false
      } else {
        input.value = cachedValue
      }

      input.addEventListener(event, (event) => {
        localStorage.setItem(inputName, event.currentTarget.value)
      })
    })
  }

  function clear_form_cache(items) {
    items.forEach(item => {
      localStorage.removeItem(item.name)
      item.value = ''
    })
  }

  setup_form_cache_listener([
    inputPostcode,
    inputStreet,
    inputDistrict,
    inputState(),
    inputCity,
    inputNumber,
    inputCnpj,
    inputCpf,
    inputPhoneNumber,
    inputFullname,
    inputEmail,
    inputIsLegalPerson,
    inputPhoneIsWhatsapp,
    inputAddressComponent,
    inputBirthDateDay,
    inputBirthDateMonth,
    inputBirthDateYear
  ])

  const termsOfServiceCont = document.getElementById('tos-root-container')
  const btnNewUserSignup = document.getElementById('btnNewUserSignup')
  const btnAlreadyRegistered = document.getElementById('btnAlreadyRegistered')

  const checkoutErrorFeedback = document.querySelector('.checkout-error-feedback')

  if (checkoutErrorFeedback && btnNewUserSignup) {
    btnNewUserSignup.dispatchEvent(new MouseEvent('click'))
    termsOfServiceCont.style.display = 'block'
  }

  if (btnNewUserSignup) {
    btnNewUserSignup.addEventListener('click', () => {
      termsOfServiceCont.style.display = 'block'

      clear_form_cache([
        inputPostcode,
        inputStreet,
        inputDistrict,
        inputState(),
        inputCity,
        inputNumber,
        inputCnpj,
        inputCpf,
        inputPhoneNumber,
        inputFullname,
        inputEmail,
        inputIsLegalPerson,
        inputPhoneIsWhatsapp,
        inputAddressComponent,
        inputBirthDateDay,
        inputBirthDateMonth,
        inputBirthDateYear
      ])
    })
  }

  if (btnAlreadyRegistered) {
    btnAlreadyRegistered.addEventListener('click', () => {
      termsOfServiceCont.style.display = 'none'
    })
  }

  if (inputIsLegalPerson.checked) {
    inputIsLegalPersonCont.dispatchEvent(new MouseEvent('click'))
    inputIsLegalPersonCont.dispatchEvent(new MouseEvent('click'))
  }

  inputIsLegalPersonCont.addEventListener('click', () => {
    const newValue = inputIsLegalPerson.checked

    update_cached_form_value([[inputIsLegalPerson, newValue]])

    inputIsLegalPerson.value = newValue
  })

  inputCountry.addEventListener('mousedown', e => e.preventDefault())

  const feedbackModal = document.getElementById('clientDetailsModal')

  // Handle address number after street1

  const inputStreetSplitted = inputStreet.value.split(', ')

  if (inputStreetSplitted.length > 1) {
    inputStreet.value = inputStreetSplitted[0]
    inputNumber = inputStreetSplitted[1]
  }

  /**
   * Validates the fields that cannot be automatically validated by HTML.
   *
   * @returns {boolean}
   */
  function hasInvalidFields() {
    let hasInvalidFields = false

    if (addressFieldsHandler.postCodeInput.value.length > 0) {
      addressFieldsHandler.setRequired(true)
      registerClientForm.reportValidity()
    }

    if (brazilFiscalDataHandler.isEnabled()) {
      if (brazilFiscalDataHandler.getIsLegalPerson()) {
        if (!Validator.isValidCNPJ(brazilFiscalDataHandler.getCnpj())) {
          hasInvalidFields = true
          Validator.setInvalid('cnpj')
        }
      }

      const cpf = brazilFiscalDataHandler.getCpf()

      if (cpf.length > 0) {
        if (!Validator.isValidCPF(cpf)) {
          hasInvalidFields = true
          formHandler.setInputInvalid(inputCpf)
          Validator.setInvalid('cpf')
        }

        if (formHandler.getBirthDate() === '') {
          hasInvalidFields = true
          Validator.setInvalid('birthdate')
        }
      }
    }

    if (portugalFiscalDataHandler.isEnabled()) {
      if (!Validator.isValidNif(portugalFiscalDataHandler.getNif())) {
        hasInvalidFields = true
        Validator.setInvalid('nif')
      }
    }

    if (
      (
        inputNewPassword1.value.length > 0 ||
        inputNewPassword2.value.length > 0
      ) &&
      inputNewPassword1.value !== inputNewPassword2.value
    ) {
      hasInvalidFields = true
      Validator.setInvalid('password')
      Validator.scrollToFirstInvalid(() => {
        formHandler.showDialog(
          LKNLANG['Passwords do not match'],
          LKNLANG['Please make sure the password field and confirm password have the same password']
        )
      })
    }

    if (inputNewPassword1.value.length === 0 || inputNewPassword2.value.length === 0) {
      hasInvalidFields = true
      Validator.setInvalid('password')
    }

    if (!phoneNumberHandler.isValidNumber()) {
      hasInvalidFields = true
      Validator.setInvalid('phonenumber')
    }

    if (inputFullname.value.split(' ').length < 2) {
      hasInvalidFields = true
      Validator.setInvalid('name')
      Validator.scrollToFirstInvalid(() => {
        formHandler.showDialog(
          LKNLANG['Incomplete name'],
          LKNLANG['Please enter your first and last name']
        )
      })
    }

    return hasInvalidFields
  }

  const restrictTypingToOnlyNumbers = evt => {
    evt = (evt) || window.event

    const charCode = (evt.which) ? evt.which : evt.keyCode
    const ctrlPressed = evt.ctrlKey || evt.metaKey
    const arrowKeysCodes = [37, 38, 39, 40]
    const allowedKeysCodes = [
      9,
      8, // Backspace
      187, // +
      46, // Delete
      116, // F5
      36, // Home
      35 // End
    ]

    if (
      (charCode >= 48 && charCode <= 57 && !evt.shiftKey) || // up keyboard number
      (charCode >= 96 && charCode <= 105) || // numpad keys
      (charCode === 67 && ctrlPressed) || // CTRL + C
      (charCode === 86 && ctrlPressed) || // CTRL + V
      (charCode === 65 && ctrlPressed) || // CTRL + A
      (charCode === 88 && ctrlPressed) || // CTRL + A
      allowedKeysCodes.includes(charCode) ||
      arrowKeysCodes.includes(charCode)
    ) {
      return true
    } else {
      evt.preventDefault()
      return false
    }
  }

  // TODO: adicionar variáveis dos constructors como privadas, quando necessário.
  class Formatter {
    static removeNonNumber = (value) => value.replace(/\D/g, '')
  }

  class Validator {
    static relations = {
      name: inputFullname,
      email: inputEmail,
      phonenumber: inputPhoneNumber,
      country: inputCountry,
      postcode: inputPostcode,
      address1: inputStreet,
      address2: inputDistrict,
      city: inputCity,
      number: inputNumber,
      state: inputState(),
      cpf: inputCpf,
      cnpj: inputCnpj,
      nif: inputNif,
      password: inputNewPassword1
    }

    /**
     * @see https://pt.wikipedia.org/wiki/N%C3%BAmero_de_identifica%C3%A7%C3%A3o_fiscal#Exemplo_de_valida%C3%A7%C3%A3o_em_JavaScript
     *
     * @param {string} value
     *
     * @returns {boolean}
     */
    static isValidNif(value) {
      const nif = typeof value === 'string' ? value : value.toString()
      const validationSets = {
        one: ['1', '2', '3', '5', '6', '8'],
        two: ['45', '70', '71', '72', '74', '75', '77', '79', '90', '91', '98', '99']
      }
      if (nif.length !== 9) return false
      if (!validationSets.one.includes(nif.substr(0, 1)) && !validationSets.two.includes(nif.substr(0, 2))) return false
      const total = nif[0] * 9 + nif[1] * 8 + nif[2] * 7 + nif[3] * 6 + nif[4] * 5 + nif[5] * 4 + nif[6] * 3 + nif[7] * 2
      const modulo11 = (Number(total) % 11)
      const checkDigit = modulo11 < 2 ? 0 : 11 - modulo11
      return checkDigit === Number(nif[8])
    }

    /**
     * @see https://gist.github.com/alexbruno/6623b5afa847f891de9cb6f704d86d02
     *
     * @param {string} value
     *
     * @returns {boolean}
     */
    static isValidCNPJ(value) {
      if (!value) return false

      // Aceita receber o valor como string, número ou array com todos os dígitos
      const isString = typeof value === 'string'
      const validTypes = isString || Number.isInteger(value) || Array.isArray(value)

      // Elimina valor em formato inválido
      if (!validTypes) return false

      // Filtro inicial para entradas do tipo string
      if (isString) {
        // Limita ao máximo de 18 caracteres, para CNPJ formatado
        if (value.length > 18) return false

        // Teste Regex para veificar se é uma string apenas dígitos válida
        const digitsOnly = /^\d{14}$/.test(value)
        // Teste Regex para verificar se é uma string formatada válida
        const validFormat = /^\d{2}.\d{3}.\d{3}\/\d{4}-\d{2}$/.test(value)

        // Se o formato é válido, usa um truque para seguir o fluxo da validação
        if (digitsOnly || validFormat) return true
        // Se não, retorna inválido
        else return false
      }

      // Guarda um array com todos os dígitos do valor
      const match = value.toString().match(/\d/g)
      const numbers = Array.isArray(match) ? match.map(Number) : []

      // Valida a quantidade de dígitos
      if (numbers.length !== 14) return false

      // Elimina inválidos com todos os dígitos iguais
      const items = [...new Set(numbers)]
      if (items.length === 1) return false

      // Cálculo validador
      const calc = (x) => {
        const slice = numbers.slice(0, x)
        let factor = x - 7
        let sum = 0

        for (let i = x; i >= 1; i--) {
          const n = slice[x - i]
          sum += n * factor--
          if (factor < 2) factor = 9
        }

        const result = 11 - (sum % 11)

        return result > 9 ? 0 : result
      }

      // Separa os 2 últimos dígitos de verificadores
      const digits = numbers.slice(12)

      // Valida 1o. dígito verificador
      const digit0 = calc(12)
      if (digit0 !== digits[0]) return false

      // Valida 2o. dígito verificador
      const digit1 = calc(13)
      return digit1 === digits[1]
    }

    /**
     * @see https://gist.github.com/alexbruno/cfb9f33cd49434bde9a40cfa6743e675
     *
     * @param {string} value
     *
     * @returns {boolean}
     */
    static isValidCPF(value) {
      if (!value) return false

      // Aceita receber o valor como string, número ou array com todos os dígitos
      const validTypes =
        typeof value === 'string' || Number.isInteger(value) || Array.isArray(value)

      // Elimina valores com formato inválido
      if (!validTypes) return false

      // Guarda todos os dígitos em um array
      const numbers = value.toString().match(/\d/g).map(Number)

      // Valida quantidade de dígitos
      if (numbers.length !== 11) return false

      // Elimina valores inválidos com todos os dígitos repetidos
      const items = [...new Set(numbers)]
      if (items.length === 1) return false

      // Separa número base do dígito verificador
      const base = numbers.slice(0, 9)
      const digits = numbers.slice(9)

      // Cálculo base
      const calc = (n, i, x) => n * (x - i)

      // Utilitário de soma
      const sum = (r, n) => r + n

      // Cálculo de dígito verificador
      const digit = (n) => {
        const rest = n % numbers.length
        return rest < 2 ? 0 : numbers.length - rest
      }

      // Cálculo sobre o número base
      const calc0 = base.map((n, i) => calc(n, i, numbers.length - 1)).reduce(sum, 0)
      // 1o. dígito verificador
      const digit0 = digit(calc0)

      // Valida 1o. digito verificador
      if (digit0 !== digits[0]) return false

      // Cálculo sobre o número base + 1o. dígito verificador
      const calc1 = base
        .concat(digit0)
        .map((n, i) => calc(n, i, numbers.length))
        .reduce(sum, 0)
      // 2o. dígito verificador
      const digit1 = digit(calc1)

      // Valida 2o. dígito verificador
      return digit1 === digits[1]
    }

    static addRedBorder(inputElement) {
      inputElement.style.border = '1px solid #E31E17'

      const removeEvent = inputElement.tagName === 'SELECT' ? 'change' : 'click'

      inputElement.addEventListener(removeEvent, () => {
        setTimeout(() => {
          inputElement.style.borderColor = 'lightgray'
        }, 500)
      }, { once: true })
    }

    static setInvalid(field) {
      if (field === 'birthdate') {
        this.addRedBorder(inputBirthDateDay)
        this.addRedBorder(inputBirthDateMonth)
        this.addRedBorder(inputBirthDateYear)

        return
      }

      if (field in this.relations) {
        const element = this.relations[field]

        if (field === 'password') {
          this.addRedBorder(inputNewPassword2)
        }

        this.addRedBorder(element)
      }
    }

    static scrollToFirstInvalid(callback) {
      const firstElementWithError = Object.entries(this.relations)
        .find(relation => {
          return relation[1].style.borderColor === 'rgb(227, 30, 23)'
        })

      if (firstElementWithError) {
        this.scrollAndCall(firstElementWithError[1], callback)
      } else if (callback) {
        callback()
      }
    }

    static scrollAndCall(element, callback) {
      element.scrollIntoView({
        behavior: 'smooth',
        block: 'center',
        inline: 'center'
      })

      let scrollingTimer = null

      function handleScroll() {
        clearTimeout(scrollingTimer)
        scrollingTimer = setTimeout(function () {
          if (callback) {
            callback()
          }
          window.removeEventListener('scroll', handleScroll)
        }, 5)
      }

      window.addEventListener('scroll', handleScroll)
    }
  }

  class PhoneNumberHandler {
    /**
     * @param {HTMLElement} htmlElement
     * @param {string} initialValue
     */
    constructor(htmlElement, initialValue = '') {
      this.htmlElement = htmlElement
      this.intl = intlTelInput(htmlElement, INTL_TEL_INPUT_SETTINGS)

      if (initialValue !== '') this.setNumber(initialValue)

      this.htmlElement.addEventListener('keydown', restrictTypingToOnlyNumbers)
    }

    /**
   * @param {string} value
   */
    setNumber(value) {
      const number = Formatter.removeNonNumber(value)
      this.intl.setNumber(`+${number}`)
    }

    /**
   * Returns the phone number without the dial code.
   *
   * @returns {string}
   */
    getNumber() {
      return (this.intl.getNumber()).replace(`+${this.getDialCode()}`, '')
    }

    /**
   * @returns {string}
   */
    getDialCode() {
      return this.intl.getSelectedCountryData().dialCode
    }

    getCountryCode() {
      return this.intl.getSelectedCountryData().iso2.toUpperCase()
    }

    /**
   * Returns the phone number with the dial code.
   * @returns {string}
   */
    getFullNumber() {
      return `${this.getDialCode()}${this.getNumber()}`
    }

    /**
     * @returns {string}
     */
    isValidNumber() {
      return this.intl.isValidNumber()
    }

    /**
     * @returns {string}
     */
    getPersistableNumber() {
      return `+${this.getDialCode()}.${this.getNumber()}`
    }

    /**
     * Retuns intl.getSelectedCountryData() to the callback.
     *
     * @param {Function} callback
     */
    setOnCountryChange(callback) {
      const thisIntl = this.intl

      this.htmlElement.addEventListener('countrychange', function () {
        callback(thisIntl.getSelectedCountryData())
      })
    }
  }

  class Form {
    /**
     * @param {HTMLButtonElement} submitBtn
     * @param {HTMLDivElement} fiscalDataCont
     * @param {HTMLDivElement} modal
     */
    constructor(submitBtn, fiscalDataCont, modal) {
      this.submitBtn = submitBtn
      this.fiscalDataCont = fiscalDataCont
      this.modal = modal
    }

    /**
     * @param {string} title
     * @param {string} msg
     */
    showDialog(title, msg = '', showFooterAndCloseBtn = true, backdrop = false) {
      this.modal.querySelector('.modal-title').innerHTML = title
      this.modal.querySelector('.modal-body > p').innerHTML = msg

      showFooterAndCloseBtn = showFooterAndCloseBtn ? 'flex' : 'none'
      this.modal.querySelector('.modal-footer').style.display = showFooterAndCloseBtn

      const options = {}

      if (backdrop) {
        options.backdrop = 'static'
        options.focus = true
        options.keyboard = false
      }

      $('#clientDetailsModal').modal(options)
    }

    /**
     * @param {HTMLElement} element
     */
    setInputInvalid(element) {
      element.style.borderColor = '#ff5a5a'

      element.addEventListener('click', (event) => {
        element.style.borderColor = '#ddd'
      }, { once: true })
    }

    hideFiscalDataCard() { this.fiscalDataCont.style.display = 'none' }
    showFiscalDataCard() { this.fiscalDataCont.style.display = 'flex' }

    enableSubmitBtn() { this.submitBtn.disabled = false }
    disableSubmitBtn() { this.submitBtn.disabled = true }

    /**
     * @param {HTMLSelectElement} inputBirthDateYear
     * @param {HTMLSelectElement} inputBirthDateMonth
     * @param {HTMLSelectElement} inputBirthDateDay
     */
    setBirthDateInputs(inputBirthDateYear, inputBirthDateMonth, inputBirthDateDay) {
      this.birthDateYearInput = inputBirthDateYear
      this.birthDateMonthInput = inputBirthDateMonth
      this.birthDateDayInput = inputBirthDateDay
    }

    /**
     * @returns {string}
     */
    getBirthDate() {
      if (
        this.birthDateYearInput.value === '' ||
        this.birthDateMonthInput.value === '' ||
        this.birthDateDayInput.value === ''
      ) {
        return ''
      }

      return new Date(
        this.birthDateYearInput.value + '-' +
        this.birthDateMonthInput.value + '-' +
        this.birthDateDayInput.value
      ).toISOString()
    }
  }

  class Requester {
    /**
     *
     * @param {string} url
     * @param {string} method
     * @param {Object} requestBody
     * @param {Function} beforeStart
     * @param {Function} onThen
     * @param {Function} onFinally
     * @param {Function} onCatch
     */
    static request(url, method, requestBody, beforeStart, onThen, onFinally, onCatch = (a) => { }) {
      beforeStart()
      const configs = { method }

      if (method === 'POST') {
        configs.body = JSON.stringify(requestBody)
      }

      fetch(url, configs)
        .then((res) => res.json())
        .then((res) => {
          onThen(res)
        })
        .catch((error) => {
          onCatch(error)
          console.error(error)
        })
        .finally(() => {
          onFinally()
        })
    }
  }

  class AddressFields {
    /**
     * @param {HTMLInputElement} postCodeInput
     * @param {HTMLInputElement|HTMLSelectElement} countryInput
     * @param {HTMLInputElement} streetInput
     * @param {HTMLInputElement} districtInput bairro.
     * @param {HTMLInputElement} numberInput
     * @param {Function} stateInput
     * @param {HTMLInputElement} cityInput
     */
    constructor(postCodeInput, countryInput, streetInput, districtInput, numberInput, stateInput, cityInput) {
      this.postCodeInput = postCodeInput
      this.countryInput = countryInput
      this.streetInput = streetInput
      this.districtInput = districtInput
      this.numberInput = numberInput
      this.stateInput = stateInput
      this.cityInput = cityInput

      this.postCodeInput.maxLength = 50
      this.streetInput.maxLength = 50
      this.districtInput.maxLength = 50
      this.cityInput.maxLength = 50
      let gotState = this.stateInput()

      if ('maxLength' in gotState) {
        this.stateInput().maxLength = 50
      }
      this.numberInput.addEventListener('keydown', restrictTypingToOnlyNumbers)
      this.postCodeInput.addEventListener('keydown', restrictTypingToOnlyNumbers)
    }

    /**
     * @returns {string}
     */
    getPostCode() { return Formatter.removeNonNumber(this.postCodeInput.value) }

    /**
     * @returns {string}
     */
    getCountry() { return this.countryInput.value }

    /**
     * @returns {string}
     */
    getStreet() { return this.streetInput.value }

    /**
     * @returns {string}
     */
    getDistrict() { return this.districtInput.value }

    /**
     * @returns {string}
     */
    getNumber() { return Formatter.removeNonNumber(this.numberInput.value) }

    /**
     * @returns {string}
     */
    getState() {
      let state = this.stateInput().value

      return this.stateInput().value
    }

    /**
     * @returns {string}
     */
    getCity() { return this.cityInput.value }

    /**
     * @param {boolean} areRequired
     */
    setRequired(areRequired) {
      this.countryInput.required = areRequired
      this.streetInput.required = areRequired
      this.districtInput.required = areRequired
      this.numberInput.required = areRequired
      this.stateInput().required = areRequired
      this.cityInput.required = areRequired
    }

    /**
     * @param {string} streetValue
     * @param {string} districtValue
     * @param {string} stateValue
     * @param {string} cityValue
     * @param {string} numberValue
     */
    updateFieldsValues(streetValue, districtValue, stateValue, cityValue, numberValue) {
      this.streetInput.value = streetValue
      this.districtInput.value = districtValue
      this.stateInput().value = stateValue
      this.cityInput.value = cityValue
      this.numberInput.value = numberValue

      update_cached_form_value([
        [this.streetInput, this.streetInput.value],
        [this.districtInput, this.districtInput.value],
        [this.stateInput(), this.stateInput().value],
        [this.cityInput, this.cityInput.value],
        [this.numberInput, this.numberInput.value],
      ])
    }

    warnInvalidPostcode() {
      const helpBlock = this.postCodeInput.parentElement.querySelector('.help-block')

      this.resetFieldsValues()

      this.postCodeInput.addEventListener('keydown', () => {
        helpBlock.style.display = 'none'
      }, { once: true })

      helpBlock.style.display = 'block'
    }

    resetFieldsValues() {
      this.updateFieldsValues('', '', '', '', '')
    }

    /**
     * Necessary because the state input is a select when Brazil is selected as country
     * and this actions changes the input class/id.
     *
     * @param {HTMLInputElement} element
     */
    updateStateInput(element) {
      this.stateInput = element
    }

    setDisabled(disable) {
      this.postCodeInput.disabled = disable
      this.streetInput.disabled = disable
      this.districtInput.disabled = disable
      this.numberInput.disabled = disable
      this.stateInput().disabled = disable
      this.cityInput.disabled = disable
    }

    /**
     * Selects a new country in the countries select and
     * dispatch the change event for the same select.
     *
     * @param {string} countryIso
     */
    setCountry(countryIso) {
      this.countryInput.value = countryIso
      this.countryInput.dispatchEvent(new Event('change'))
    }
  }

  class BrazilFiscalDataFields {
    constructor() {
      this.cnpjDisplayHidden = false
    }

    isEnabled() {
      return this.fiscalDataCont.style.display !== 'none'
    }

    /**
     * @returns {string}
     */
    getCpf() {
      return Formatter.removeNonNumber(this.cpfInput.value)
    }

    /**
     * @returns {string}
     */
    getCnpj() {
      return Formatter.removeNonNumber(this.cnpjInput.value)
    }

    /**
     * @returns {string}
     */
    getCnpjTradeName() {
      return this.cnpjTradeName.value
    }

    /**
     * @returns {string}
     */
    getCnpjLegalName() {
      return this.cnpjLegalName.value
    }

    /**
     * @returns {boolean}
     */
    getIsLegalPerson() {
      return this.isLegalPersonInput.checked
    }

    /**
     * @param {HTMLDivElement} element
     */
    setFieldsParentCont(element) {
      this.fiscalDataCont = element
    }

    /**
     * @param {HTMLInputElement} element
     * @param {HTMLDivElement} cont
     */
    setCpfInput(element, cont) {
      this.cpfInput = element
      this.cpfInputCont = cont

      this.cpfInput.placeholder = '000.000.000-00'
      this.cpfInput.maxLength = 14
      this.cpfInput.addEventListener('keydown', restrictTypingToOnlyNumbers)
    }

    /**
     * @param {HTMLInputElement} element
     * @param {HTMLDivElement} cont
     */
    setCnpjInput(element, cont) {
      this.cnpjInput = element
      this.cnpjInputCont = cont

      this.cnpjInput.placeholder = '00.000.000/0000-00'
      this.cnpjInput.setAttribute('maxlength', 18)
      this.cnpjInput.addEventListener('keydown', restrictTypingToOnlyNumbers)
    }

    /**
     * @param {HTMLInputElement} element
     */
    setIsLegalPersonInput(element) {
      this.isLegalPersonInput = element
    }

    /**
     * @param {HTMLInputElement} element
     * @param {HTMLDivElement} cont
     */
    setCnpjTradeName(element, cont) { this.cnpjTradeName = element; this.cnpjTradeNameCont = cont }

    /**
     * @param {HTMLInputElement} element
     * @param {HTMLDivElement} cont
     */
    setCnpjLegalName(element, cont) { this.cnpjLegalName = element; this.cnpjLegalNameCont = cont }

    /**
     * @param {HTMLInputElement} element
     * @param {HTMLDivElement} cont
     */
    setStateRegistration(element, cont) { this.stateRegistration = element; this.stateRegistrationCont = cont }

    /**
     * @param {string} display
     */
    changeDisplay(display) {
      this.fiscalDataCont.style.display = display

      if (display === 'none') {
        this.cpfInput.required = false
        formHandler.birthDateDayInput.required = false
        formHandler.birthDateMonthInput.required = false
        formHandler.birthDateYearInput.required = false
      } else {
        this.cpfInput.required = true
        formHandler.birthDateDayInput.required = true
        formHandler.birthDateMonthInput.required = true
        formHandler.birthDateYearInput.required = true
      }
    }

    setCnpjLegalNameValue(value) { this.cnpjLegalName.value = value }
    setCnpjTradeNameValue(value) { this.cnpjTradeName.value = value }

    hideAllFields() { this.changeDisplay('none') }
    showAllFields() { this.changeDisplay('flex') }

    /**
     * @param {boolean} display
     */
    setCnpjDisplay(display) {
      this.cnpjDisplayHidden = !display
      const displayStyle = display ? 'block' : 'none'

      this.cnpjInputCont.style.display = displayStyle
      this.cnpjInput.required = displayStyle === 'block'
    }
  }

  class PortugalFiscalDataFields {
    /**
     * @returns {boolean}
     */
    isEnabled() {
      return this.fiscalDataCont.style.display !== 'none'
    }

    /**
     * @returns {string}
     */
    getNif() {
      return Formatter.removeNonNumber(this.nifInput.value)
    }

    /**
     * @param {HTMLDivElement} element
     */
    setFieldsParentCont(element) {
      this.fiscalDataCont = element
    }

    /**
     * @param {HTMLInputElement} nifInput
     */
    setNifInput(nifInput) {
      this.nifInput = nifInput

      this.nifInput.addEventListener('keydown', restrictTypingToOnlyNumbers)
      this.nifInput.maxLength = 9
    }

    /**
     * @param {HTMLInputElement} element
     * @param {HTMLInputElement} cont
     */
    setCnpjTradeName(element, cont) { this.nifInput = element; this.nifInputCont = cont }

    /**
     * @param {string} display
     */
    changeDisplay(display) {
      this.fiscalDataCont.style.display = display
    }

    hideAllFields() { this.changeDisplay('none') }
    showAllFields() { this.changeDisplay('flex') }
  }

  const formHandler = new Form(submitBtn, fiscalDataCont, feedbackModal)
  formHandler.setBirthDateInputs(
    inputBirthDateYear,
    inputBirthDateMonth,
    inputBirthDateDay
  )

  const brazilFiscalDataHandler = new BrazilFiscalDataFields()

  brazilFiscalDataHandler.setFieldsParentCont(brFiscalDataCont)
  brazilFiscalDataHandler.setCpfInput(inputCpf, formGroupCpf)
  brazilFiscalDataHandler.setCnpjInput(inputCnpj, formGroupCnpj)
  brazilFiscalDataHandler.setCnpjLegalName(hiddenCnpjLegalName)
  brazilFiscalDataHandler.setCnpjTradeName(hiddenCnpjTradeName)
  brazilFiscalDataHandler.setIsLegalPersonInput(inputIsLegalPerson)

  brazilFiscalDataHandler.setCnpjDisplay(false)

  const portugalFiscalDataHandler = new PortugalFiscalDataFields()
  portugalFiscalDataHandler.setNifInput(inputNif)
  portugalFiscalDataHandler.setFieldsParentCont(ptFiscalDataCont)
  portugalFiscalDataHandler.hideAllFields()

  const phoneNumberHandler = new PhoneNumberHandler(inputPhoneNumber)
  phoneNumberHandler.setOnCountryChange(function (countryData) {
    const countryCode = countryData.iso2.toUpperCase()

    inputCountry.value = countryCode

    inputCountry.dispatchEvent(new Event('change'))

    handleDisplayOfTaxDataSection()
  })

  const addressFieldsHandler = new AddressFields(
    inputPostcode,
    inputCountry,
    inputStreet,
    inputDistrict,
    inputNumber,
    inputState,
    inputCity
  )

  function handleDisplayOfTaxDataSection() {
    if (phoneNumberHandler.isValidNumber()) {
      const countryData = phoneNumberHandler.intl.getSelectedCountryData()
      const countryIso2 = countryData.iso2.toUpperCase()

      inputCountry.value = countryIso2

      if (['PT', 'BR'].includes(countryIso2)) {
        switch (countryIso2) {
          case 'BR':
            formHandler.showFiscalDataCard()
            portugalFiscalDataHandler.hideAllFields()

            brazilFiscalDataHandler.showAllFields()
            break

          case 'PT':
            formHandler.showFiscalDataCard()
            brazilFiscalDataHandler.hideAllFields()

            portugalFiscalDataHandler.showAllFields()
            break

          default:
            formHandler.hideFiscalDataCard()
            brazilFiscalDataHandler.hideAllFields()
            portugalFiscalDataHandler.hideAllFields()

            break
        }

        $('#taxDataCard').slideDown()
      } else {
        $('#taxDataCard').slideUp()
      }
    } else {
      $('#taxDataCard').slideUp()
    }
  }

  inputPhoneNumber.addEventListener('blur', () => {
    handleDisplayOfTaxDataSection()
  })

  /**
   * @param {KeyboardEvent} event
   */
  function handleInputPostcodeType(event) {
    const postCode = inputPostcode.value.replace(/\D/g, '')
    const isNumberKey = !isNaN(parseInt(event.key))

    if (!isNumberKey || postCode.length === 0) {
      addressFieldsHandler.setRequired(false)

      return
    }

    if (inputCountry.value === 'BR' && postCode.length === 8) {
      addressFieldsHandler.setRequired(true)

      const requestUrl = `https://viacep.com.br/ws/${postCode}/json/`

      const beforeStart = () => {
        formHandler.disableSubmitBtn()
        addressFieldsHandler.setDisabled(true)
      }

      const onFinally = () => {
        formHandler.enableSubmitBtn()
        addressFieldsHandler.setDisabled(false)
      }

      const onThen = (res) => {
        if (!res || !res.localidade) {
          addressFieldsHandler.warnInvalidPostcode()

          return
        }

        addressFieldsHandler.updateFieldsValues(
          res.logradouro,
          res.bairro ?? '',
          res.uf ?? '',
          res?.localidade ?? '',
          ''
        )
      }

      Requester.request(requestUrl, 'GET', {}, beforeStart, onThen, onFinally)
    } else if (inputCountry.value === 'PT' && postCode.length > 6) {
      addressFieldsHandler.setRequired(true)

      const requestUrl = 'https://json.geoapi.pt/codigo_postal/' + postCode

      const beforeStart = () => {
        formHandler.disableSubmitBtn()
        addressFieldsHandler.setDisabled(true)
      }

      const onFinally = () => {
        formHandler.enableSubmitBtn()
        addressFieldsHandler.setDisabled(false)
      }

      const onThen = (res) => {
        if (!res || !res['Designação Postal']) {
          addressFieldsHandler.warnInvalidPostcode()

          return
        }

        let designacaoPostal = res['Designação Postal'] ? res['Designação Postal'].toLowerCase() : false
        designacaoPostal = designacaoPostal ? designacaoPostal.charAt(0).toUpperCase() + designacaoPostal.slice(1) : false

        let rua = res.ruas && res.ruas.length > 0 ? res.ruas[0].toLowerCase() : ''
        rua = rua.toLowerCase().replace(/(?:^|\s)\w/g, match => match.toUpperCase())

        const street = rua
        const district = (designacaoPostal ? (designacaoPostal + ', ') : '') + (res.Localidade ?? '')
        const state = res.Distrito ?? ''
        const city = res.Concelho ?? ''

        addressFieldsHandler.updateFieldsValues(
          street,
          district,
          state,
          city,
          ''
        )
      }

      Requester.request(requestUrl, 'GET', {}, beforeStart, onThen, onFinally)
    }
  }

  brazilFiscalDataHandler.setCnpjDisplay(inputIsLegalPerson.checked)

  inputIsLegalPersonCont.addEventListener('click', event => {
    brazilFiscalDataHandler.setCnpjDisplay(!!brazilFiscalDataHandler.cnpjDisplayHidden)
  })

  inputPostcode.addEventListener('keydown', restrictTypingToOnlyNumbers)

  inputPostcode.addEventListener('keyup', handleInputPostcodeType)

  inputCountry.addEventListener('change', event => {
    addressFieldsHandler.resetFieldsValues()

    switch (inputCountry.value) {
      case 'BR':
        formHandler.showFiscalDataCard()
        portugalFiscalDataHandler.hideAllFields()

        brazilFiscalDataHandler.showAllFields()
        break

      case 'PT':
        formHandler.showFiscalDataCard()
        brazilFiscalDataHandler.hideAllFields()

        portugalFiscalDataHandler.showAllFields()
        break

      default:
        formHandler.hideFiscalDataCard()
        brazilFiscalDataHandler.hideAllFields()
        portugalFiscalDataHandler.hideAllFields()

        break
    }
  })

  submitBtn.addEventListener('click', event => {
    event.preventDefault()

    registerClientForm.reportValidity()

    let hasInvalidFields = false

    const invalidElements = registerClientForm.querySelectorAll(':invalid')

    invalidElements.forEach(el => {
      Validator.addRedBorder(el)
    })

    if (!registerClientForm.checkValidity()) {
      hasInvalidFields = true
    }

    if (brazilFiscalDataHandler.isEnabled()) {
      if (brazilFiscalDataHandler.getIsLegalPerson()) {
        if (!Validator.isValidCNPJ(brazilFiscalDataHandler.getCnpj())) {
          hasInvalidFields = true
          Validator.setInvalid('cnpj')
        }
      }

      const cpf = brazilFiscalDataHandler.getCpf()

      if (cpf.length > 0) {
        if (!Validator.isValidCPF(cpf)) {
          hasInvalidFields = true
          formHandler.setInputInvalid(inputCpf)
          Validator.setInvalid('cpf')
        }

        if (!formHandler.getBirthDate()) {
          hasInvalidFields = true
          Validator.setInvalid('birthdate')
        }
      }
    }

    if (portugalFiscalDataHandler.isEnabled()) {
      if (!Validator.isValidNif(portugalFiscalDataHandler.getNif())) {
        hasInvalidFields = true
        Validator.setInvalid('nif')
      }
    }

    if (hasInvalidFields) {
      Validator.scrollToFirstInvalid()

      return
    }

    let [firstName, ...lastName] = inputFullname.value.trim().split(' ')

    lastName = lastName.join(' ')

    const originalFirstNameInput = document.querySelector('input[name="firstname"]')
    const originalLastNameInput = document.querySelector('input[name="lastname"]')
    const originalPhoneNumberInput = document.querySelector('input[name="phonenumber"]')

    originalFirstNameInput.value = firstName
    originalLastNameInput.value = lastName
    originalPhoneNumberInput.value = phoneNumberHandler.getPersistableNumber()
    inputStreet.value = `${inputStreet.value}, ${inputNumber.value}`

    submitBtn.disabled = true

    setTimeout(() => { registerClientForm.submit() }, 1000)
  })

  VMasker(inputCpf).maskPattern('999.999.999-99')
  VMasker(inputCnpj).maskPattern('99.999.999/9999-99')
  VMasker(inputNif).maskPattern('999999999')
})
