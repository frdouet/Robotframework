*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${Browser}       Chrome
${URL}           http://automationexercise.com
${SEARCH_BAR}    id=submit_search
${SEARCH_TEXT}    men tshirt
${SEARCH_BUTTON}  id=submit_search


*** Test Cases ***
Example Test

    Open Browser    ${URL}    ${Browser}  --disable-popup-blocking
    Delete All Cookies
    Navigate To Page
    Input Text To Search Field    men tshirt
    Click Search Button
    Set Selenium Timeout    10s
    Scroll Page Down
    Set Selenium Timeout    20s
    Add Product To Cart
    Scroll Page Up
    Maximize Browser Window
    Click Continue Shopping Button  //div[@class="modal-content"]
    Scroll Page Down
    Add Product To Cart
    Click Cart Button
    Click Element    css=#cart_items a.check_out
    Verify Products In Cart   //div[.//*[@id='do_action']]
    Verify Total Price Is Correct

*** Keywords ***
Navigate To Page
    Click Element    xpath=//a[contains(text(),'Products')]

Input Text To Search Field
    [Arguments]    ${text}
    Input Text    id=search_product    ${text}

Click Search Button
    Click Element    id=submit_search

Add Product To Cart
    Click Element    css=a[data-product-id="2"]

Scroll Page Down
    Execute JavaScript    window.scrollBy(0, 500)

Scroll Page Up
    Execute JavaScript    window.scrollTo(0, -document.body.scrollHeight)

Click Continue Shopping Button
      [Arguments]    ${locator}
         # Attendez que la fenêtre modale soit visible
         Wait Until Element Is Visible    ${locator}
         # Cliquez sur le bouton "Continue Shopping"
         Click Element    xpath=${locator}//button[@class="btn btn-success close-modal btn-block"]

Click Cart Button
    Click Element    xpath=//a[contains(text(),'Cart')]

Verify Products In Cart
    [Arguments]    ${locator}
        # Vérifier les valeurs dans les colonnes de la première ligne
         ${price_text}    Get Text    css=td.cart_price p
                    Log    ${price_text}
        Should Be Equal As Strings    ${price_text}    Rs. 400
        # Ajouter plus de validations au besoin

Verify Total Price Is Correct
    ${total_price_text}    Get Text    xpath=//p[@class='cart_total_price']
    Log    ${total_price_text}
     Should Be Equal    ${total_price_text}    Rs. 800

