header {
package com.bea.console.utils.diagnostics.query;
}
/**
 *
 * @author Copyright (c) 2003,2009, Oracle and/or its affiliates. All rights reserved.
 * @version
 */
class QueryExpressionParser extends Parser;
options {
  defaultErrorHandler=false;
  buildAST=true;
}
tokens {
  CONSTANT_BOOLEAN<AST=antlr.CommonAST>;
  CONSTANT_NUMBER<AST=antlr.CommonAST>;
  STRING_LITERAL<AST=antlr.CommonAST>;
  VARIABLE_NAME<AST=antlr.CommonAST>;
  SET_NODE<AST=antlr.CommonAST>;
  AND="AND";
  OR="OR";
  NOT="NOT";
  LIKE="LIKE";
  MATCHES="MATCHES";
  IN="IN";
}

booleanExpression
    : logicalExpression END_OF_QUERY!;

logicalExpression
    :relationalExpression ((AND^|OR^) relationalExpression)*;

relationalExpression
    : (atom IN) => atom (IN^) setNode
    | (atom LIKE) => atom (LIKE^) STRING_LITERAL
    | (atom MATCHES) => atom (MATCHES^) STRING_LITERAL
    | atom (LT^|GT^|LE^|GE^|EQ^|NE^) atom
    | unaryExpression
    ;

unaryExpression 
    : NOT^ nestedExpression 
    | nestedExpression
    ;

nestedExpression 
    : LPAREN^ logicalExpression RPAREN!;

atom
    : CONSTANT_BOOLEAN
    | CONSTANT_NUMBER
    | STRING_LITERAL
    | VARIABLE_NAME
    ;

setNode
    : s:LPAREN^ constantNumberOrString (COMMA! constantNumberOrString)* RPAREN!
     {#s.setType(SET_NODE);}
    ;

constantNumberOrString: CONSTANT_NUMBER | STRING_LITERAL ;

/*
 * @author Copyright (c) 2003 by BEA Systems, Inc.  All Rights Reserved.
 * @exclude
 */
class QueryExpressionLexer extends Lexer;
options {k=2; charVocabulary='\u0000'..'\uFFFE'; testLiterals=false; defaultErrorHandler=false;}
{
  public QueryExpressionLexer(String query) {
    this(new java.io.StringReader(terminateQuery(query)));
  }

  private static String terminateQuery(String query) {
    if (query.charAt(query.length() -1) != ';') {
      query = query + ';';
    }
    return query;
  }
}

// Relational operators
LT  : "<";
GT  : ">";
LE  : "<=";
GE  : ">=";
EQ  : "=";
NE  : "!=";

END_OF_QUERY : ";" ;

// String comparison operators
// LIKE : "LIKE";
// MATCHES: "MATCHES";

// Logical operators
// AND : "AND";
// OR  : "OR";
// NOT : "NOT";

LPAREN : '(';
RPAREN : ')';

COMMA  : ',';

WS    : ( SPACE
        | '\r' '\n'
        | '\n'
        | '\t'
        )
        {$setType(Token.SKIP);}
      ;

VARIABLE_NAME options {testLiterals=true;}
  : ASCII_VARNAME_START (ASCII_VARNAME_START | DIGIT)*
  {
    String t = getText();
    if(t.equalsIgnoreCase("true") || t.equalsIgnoreCase("false")) {
      $setType(CONSTANT_BOOLEAN);
    }
  }
  | "${" (ASCII_VARNAME_START | UNICODE_CHAR | DIGIT | SPECIAL_CHARS)* "}"
  ;

CONSTANT_NUMBER : (PLUS|MINUS)? (DIGIT)+ (DOT (DIGIT)+)? (NUMBER_SUFFIXES)?;

STRING_LITERAL :  '\'' (options {greedy=false;} : ~('\'') | ESCAPED_SINGLE_QUOTE)* '\'';

protected SPACE: ' ';

// Sign symbols not as operators
protected PLUS  : "+";
protected MINUS : "-";

protected DIGIT: '0'..'9';
protected ASCII_VARNAME_START: 'a'..'z' | 'A'..'Z' | '_';
protected UNICODE_CHAR: '\u0080'..'\uffff';
protected ALIAS_DELIMITER_START: '#';
protected VARIABLE_TYPE_ENCLOSER_START: '[';
protected VARIABLE_TYPE_ENCLOSER_END: ']';
protected SPECIAL_CHARS: '@' | ':' | SPACE | ',' | '=' | '/' | '-' | '.' | '!' | ALIAS_DELIMITER_START | VARIABLE_TYPE_ENCLOSER_START | VARIABLE_TYPE_ENCLOSER_END;

// Number rules
protected DOT: '.';
protected NUMBER_SUFFIXES: DOUBLE_SUFFIX | FLOAT_SUFFIX | LONG_SUFFIX | EXPONENT;

// Number suffixes
protected DOUBLE_SUFFIX: 'D' | 'd';
protected FLOAT_SUFFIX: 'F' | 'f';
protected LONG_SUFFIX: 'L' | 'l';
protected EXPONENT: ('e' | 'E') (PLUS | MINUS)? (DIGIT)+ ;

protected ESCAPED_SINGLE_QUOTE: "\'" { $setText("'"); };
