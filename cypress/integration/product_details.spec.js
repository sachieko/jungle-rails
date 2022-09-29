/// <reference types="cypress" />

context('Product details', () => {
  beforeEach(() => {
    cy.visit('/')
  })
  describe('When we click on a product', () => {
    it('Should go to a page with that product\'s details', () => {
      cy.get('.products article').contains('Shrubbery').click();

      cy.get('.product-detail').should('contain', 'Shrubbery')
    });

  })
});