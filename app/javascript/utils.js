class Utils {
  static numberToCurrency (n, currency) {
    // Taken from https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number/toLocaleString#Browser_Compatibility
    if (!currency) {
      currency = 'USD'
    }
    return n.toLocaleString('en-US', { style: 'currency', currency: currency, minimumFractionDigits: 2 })
  }

  static sum (arr) {
    return arr.reduce((sum, e) => sum + e)
  }
}

export default Utils
