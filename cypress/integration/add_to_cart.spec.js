/// <reference types="cypress" />

context('Add item to cart', () => {
  beforeEach(() => {
    cy.visit('/')
  })
  describe('When we click on adding a product to cart', () => {
    it('Should update the amount of items in the cart from the home page', { scrollBehavior: "center" }, () => {
      cy.get('.products article > div > form > button').first().click();
      cy.get('.navbar')
        .contains('My Cart (1)');
    });
    it('Should update the number of items in the cart from the product page', () => {
      cy.get('.products article')
        .contains('Shrubbery').click();
      cy.get('.product-detail')
        .should('contain', 'Shrubbery')
        .get('.add-to-cart > form').click();
      cy.get('.navbar')
        .contains('My Cart (1)');
    });
    it('Should display the correct cart items on the cart page when we go to the part', () => {
      cy.get('.products article')
        .contains('Shrubbery').click();
      cy.get('.add-to-cart > form').click();
      cy.get('.navbar')
        .contains('My Cart (1)').click();
      cy.get('section.cart-show')
        .should('contain', 'My Cart');
      cy.get('div.items > table.table')
        .should('contain', 'Shrubbery');
    });
    
  })
});