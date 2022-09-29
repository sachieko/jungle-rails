/// <reference types="cypress" />

context('Home Page', () => {
  beforeEach(() => {
    cy.visit('/')
  })
  describe('When we navigate to the home page', () => {
    it('Should see our nav bar and products', () => {
      cy.get('.navbar').contains('About');
      cy.get('.navbar').contains('My Cart');

      cy.get('.products article').should('contain', 'Shrubbery');
      cy.get('.products article').should('have.length', 3);
    });

  })
});