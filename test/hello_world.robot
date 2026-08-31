*** Test Cases ***
hello_world on rpi_pico
    ${x}=                       Execute Command         include @${CURDIR}/test/simulate.resc
    Create Terminal Tester      sysbus.uart0    timeout=15    defaultPauseEmulation=true
    Wait For Line On Uart       hello world!
