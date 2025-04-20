### XSLT Template, `apply-templates`, and `call-template` - A Summary

1. **Template (`<xsl:template>`):**
   - **Purpose:** Defines a transformation rule in XSLT. Templates match specific parts of an XML document and specify how those parts should be processed.
   - **Example:**
     ```xslt
     <xsl:template match="book">
         <p><xsl:value-of select="title"/></p>
     </xsl:template>
     ```
     This template matches `<book>` elements and outputs their `<title>` in a paragraph.

2. **`xsl:apply-templates`:**
   - **Purpose:** This element is used to process child nodes of the current node. It applies templates to those child nodes. It is commonly used to apply templates to specific sets of nodes.
   - **Example:**
     ```xslt
     <xsl:template match="library">
         <xsl:apply-templates select="book"/>
     </xsl:template>
     ```
     This applies the templates for `<book>` elements inside the `<library>` element. It processes each `<book>` according to the templates defined for it.

3. **`xsl:call-template`:**
   - **Purpose:** This explicitly calls a named template to apply it at a specific point in the XSLT transformation. It is useful when you want to reuse templates or perform specific processing in a controlled manner.
   - **Example:**
     ```xslt
     <xsl:template name="showBook">
         <p><xsl:value-of select="title"/></p>
     </xsl:template>
     
     <xsl:template match="library">
         <xsl:call-template name="showBook"/>
     </xsl:template>
     ```
     Here, the `showBook` template is called from within another template (like `library`), allowing reuse of the logic to output the book's title.

### **Key Differences:**
- **`xsl:apply-templates`** is used for applying templates to child nodes of the current context (recursive processing).
- **`xsl:call-template`** is used to invoke a **named** template explicitly from anywhere in the stylesheet.

### **Example in Context:**
```xslt
<xsl:template match="library">
    <h2>Library Books:</h2>
    <xsl:apply-templates select="book"/>
</xsl:template>

<xsl:template match="book">
    <div>
        <xsl:value-of select="title"/>
        <xsl:value-of select="author"/>
    </div>
</xsl:template>
