<!--
    The twocollayout skeleton file is intended to be used with the
    negative margin two column technique describe on ALA
    (http://www.alistapart.com/articles/negativemargins/)

    This creates two side by side divs where one is fixed width and
    the other is liquid (dynamic). It doesn't mater what the order of the divs
    is. An extra inner div is added to the dynamic column div. It will have 
    the same presentation id as the dynamic div but with "-inner" suffix.

    To use this layout set the type attribute of the netuix:layout
    element to "twocol". There should be exactly two netuix:placeholder
    children and each should have a presentationId for use in css styling.
    It doesn't matter which comes first.

    Use caution with borders, padding and margins on these divs.

    Example of use:
    In a portal file:
    <netuix:layout type="twocol" ...>
      <netuix:placeholder presentationId="nav" usingFlow="false" title="fixed" ...>
      ...
      <netuix:placeholder presentationId="content" usingFlow="false" title="dynamic" ...>

    In a css file:

    #nav {
      float: left;
      width: {x}px;
      margin: 0px;
    }
    
    #content {
        float: right;
        width: 100%;
        margin-left: -{x}px;
    }
    
    #content-inner {
        margin-left: {x}px;
    }

    Where {x} is the width of the fixed column.

-->
<jsp:root version="2.0" 
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:skeleton="http://www.bea.com/servers/portal/tags/netuix/skeleton"
>
    <jsp:directive.page session="false" />
    <jsp:directive.page isELIgnored="false" />
    <skeleton:context type="layoutpc">
        <skeleton:control name="div" presentationContext="${layoutpc}"
            presentationClass="console-2col-layout"
        >
            <c:forEach items="${layoutpc.placeholders}" var="cell" varStatus="status">
                <skeleton:control name="div" presentationContext="${cell}">
                    <c:choose>
                    <c:when test="${cell.title eq 'dynamic'}">
                      <div id="${cell.presentationId}-inner">
                        <skeleton:child presentationContext="${cell}"/>
                      </div>
                    </c:when>
                    <c:otherwise>
                        <skeleton:child presentationContext="${cell}"/>
                    </c:otherwise>
                    </c:choose>
                </skeleton:control>
            </c:forEach>
        </skeleton:control>
    </skeleton:context>
</jsp:root>
