/**** ANTLRv4  grammar for OpenPulse1.0.

The following grammar specifies valid OpenPulse statements within the .*? of
OpenQASM3 below.

calibrationDefinition
    : 'defcal' calibrationGrammar? Identifier
    ( LPAREN calibrationArgumentList? RPAREN )? identifierList
    returnSignature? LBRACE .*? RBRACE  // for now, match anything inside body
    ;

specifically, `.*? -> body` below.

****/

grammar openpulse1;

body
    : (statement)+
    ;

statement
    : classicalAssignment
    | classicalDeclaration
    | constantDeclaration
    | aliasStatement
    | branchingStatement
    | instruction
    | pragma
    ;

instruction
    : 'play' LPAREN pulse RPAREN SEMICOLON
    | frameUpdateInstruction
    | captureInstruction
    ;

pulse
    : LBRACKET (Complex COMMA)* Complex RBRACKET
    ;

frameUpdateInstruction
    : frame DOT frameAttribute frameAssignmentOperator expression SEMICOLON
    ;

frame
    : 'frameof' LPAREN StringLiteral COMMA qubitIdentifier (COMMA qubitIdentifier)* RPAREN SEMICOLON
    ;

qubitIdentifier
    : ('%')(int)
    ;

frameAttribute
    : 'frequency'
    | 'phase'
    | 'scale'
    ;

frameAssignmentOperator
    : EQUALS
    | '+=' | '-='
    ;

captureInstruction
    : 'capture' LPAREN frame COMMA expression RPAREN SEMICOLON
    | Identifer EQUALS captureInstruction
    ;

Complex
    : RealNumber
    | (RealNumber PlusMinus)? RealNumber '*' 'j'
    ;

