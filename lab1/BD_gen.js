// code generator for lab1_6

const atoms = [
        'corn', 'wheat', 'livestock', 'rock', 'banana',
        'deer','fish','crab','vine','citrus','sugar',
        'fox','quartz','marble','silver','whale',
        'horse','iron','coal','nitre'
    ]

const parameter = 'bonus'

let resultText = ""
atoms.forEach((atom) => {
    resultText+=`${parameter}(${atom},0).\n`
})

console.log(resultText)