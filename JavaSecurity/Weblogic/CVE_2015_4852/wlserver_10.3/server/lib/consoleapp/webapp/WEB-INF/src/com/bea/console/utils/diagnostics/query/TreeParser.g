header {
package com.bea.console.utils.diagnostics.query;
import antlr.CommonAST;
import com.bea.console.utils.treeeditor.*;
}

/**
 *
 * @author Copyright (c) 2003,2009, Oracle and/or its affiliates. All rights reserved.
 * @version
 */
class QueryExpressionTreeWalker extends TreeParser;
options {
  defaultErrorHandler=false;
  importVocab=QueryExpressionParser;
}

evaluateQuery returns [TreeNode r = null;] 
{ TreeNode a, b; String at1 ,at2; }
    : #(AND a=evaluateQuery b=evaluateQuery)
    {
      OperatorNode andNode = NodeFactory.createOperator(NodeType.AND, null);

      if (a instanceof OperatorNode) {
        OperatorNode opNode = (OperatorNode)a;
        if (opNode.getType() == NodeType.LOGICAL) {
          opNode.addChild(andNode);
          opNode.addChild(b);
          r = opNode;
        } else {
          r = NodeFactory.createOperator(NodeType.LOGICAL, new TreeNode[]{a, andNode, b});
        }
      } else {
        r = NodeFactory.createOperator(NodeType.LOGICAL, new TreeNode[]{a, andNode, b});
      }
    }
    | #(OR a=evaluateQuery b=evaluateQuery)
    {
      OperatorNode orNode = NodeFactory.createOperator(NodeType.OR, null);

      if (a instanceof OperatorNode) {
        OperatorNode opNode = (OperatorNode)a;
        if (opNode.getType() == NodeType.LOGICAL) {
          opNode.addChild(orNode);
          opNode.addChild(b);
          r = opNode;
        } else {
          r = NodeFactory.createOperator(NodeType.LOGICAL, new TreeNode[]{a, orNode, b});
        }
      } else {
        r = NodeFactory.createOperator(NodeType.LOGICAL, new TreeNode[]{a, orNode, b});
      }
    }
    | #(NOT a=evaluateQuery)
    {
      r = NodeFactory.createOperator(NodeType.NOT, new TreeNode[]{a});
    }
    | #(LT at1=atom at2=atom)
    {
      r = NodeFactory.createLiteral(at1 + " < " + at2);
    }
    | #(GT at1=atom at2=atom)
    {
      r = NodeFactory.createLiteral(at1 + " > " + at2);
    }
    | #(LE at1=atom at2=atom)
    {
      r = NodeFactory.createLiteral(at1 + " <= " + at2);
    }
    | #(GE at1=atom at2=atom)
    {
      r = NodeFactory.createLiteral(at1 + " >= " + at2);
    }
    | #(EQ at1=atom at2=atom)
    {
      r = NodeFactory.createLiteral(at1 + " = " + at2);
    }
    | #(NE at1=atom at2=atom)
    {
      r = NodeFactory.createLiteral(at1 + " != " + at2);
    }
    | #(LIKE at1=atom at2=atom)
    {
      r = NodeFactory.createLiteral(at1 + " LIKE " + at2);
    }
    | #(MATCHES at1=atom at2=atom)
    {
      r = NodeFactory.createLiteral(at1 + " MATCHES " + at2);
    }
    | #(IN at1=atom at2=atom)
    {
      r = NodeFactory.createLiteral(at1 + " IN " + at2);
    }
    | #(LPAREN a=evaluateQuery)
    {
      if (a instanceof OperatorNode) {
        r = NodeFactory.createOperator(NodeType.GROUPING, new TreeNode[]{a});
      } else {
        r = a;
      }
    }
    ;

atom returns [String text = ((CommonAST)(_t)).getText();]
  : CONSTANT_NUMBER
  | CONSTANT_BOOLEAN
  | STRING_LITERAL
  | { CommonAST ast = (CommonAST)(_t); }  SET_NODE
    {
      CommonAST first = (CommonAST)ast.getFirstChild();
      text = "(" + first.toString();

      CommonAST next = (CommonAST)first.getNextSibling();
      while (next != null) {
        text += ", " + next.toString();
        next = (CommonAST)next.getNextSibling();
      }

      text += ")";
    ;}
  | VARIABLE_NAME
  ;
