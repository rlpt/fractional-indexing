const fi = require("./expirement.js");

describe("experiment", () => {
    test("validate order key", () => {
        try {
            console.log(fi.validateOrderKey("1", fi.BASE_62_DIGITS))
        } catch (e) {
            console.log(e)
        }

        expect(1).toBe(1)
    })
})