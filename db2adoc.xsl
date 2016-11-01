<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:strip-space elements="*"/>
  
  <xsl:template match="/">
    <xsl:apply-templates select="part"/>
  </xsl:template>

  <xsl:template match="indexterm">
    <xsl:text>&#10;indexterm:[</xsl:text><xsl:value-of select="primary"/>
    <xsl:choose>
      <xsl:when test="secondary">
	<xsl:text>, </xsl:text><xsl:value-of select="secondary"/>
      </xsl:when>
    </xsl:choose>
    <xsl:text>]</xsl:text>
  </xsl:template>

  <xsl:template match="part">

    <xsl:text>&#10;= </xsl:text>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="chapter">
    <xsl:text>&#10;&#10;== </xsl:text>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="sect1|chapter/section">
    <xsl:text>&#10;&#10;=== </xsl:text>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="sect2|chapter/section/section">
    <xsl:text>&#10;&#10;==== </xsl:text>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="sect3|chapter/section/section/section">
    <xsl:text>&#10;&#10;===== </xsl:text>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="sect4|chapter/section/section/section/section">
    <xsl:text>&#10;&#10;====== </xsl:text>
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="sect5|chapter/section/section/section/section/section">
    <xsl:text>&#10;&#10;.</xsl:text><xsl:value-of select="title"/>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="para">
    <xsl:choose>
      <xsl:when test="parent::listitem|parent::entry">
	<xsl:apply-templates/>
      </xsl:when>
      <xsl:otherwise>
	<xsl:text>&#10;</xsl:text>
	<xsl:apply-templates/>
	<xsl:text>&#10;&#10;</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="emphasis">
    <xsl:choose>
      <xsl:when test="@role!='strong'">
	<xsl:text>[</xsl:text><xsl:value-of select="@role"/><xsl:text>]##</xsl:text><xsl:apply-templates/><xsl:text>##</xsl:text>
      </xsl:when>
      <xsl:when test="@role='strong'">
	<xsl:text>**</xsl:text><xsl:apply-templates/><xsl:text>**</xsl:text>
      </xsl:when>
      <xsl:otherwise>
		<xsl:text>__</xsl:text><xsl:apply-templates/><xsl:text>__</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="graphic|inlinegraphic">
    <xsl:text>image::</xsl:text><xsl:value-of select="@fileref"/><xsl:text>[]&#10;</xsl:text>
  </xsl:template>

  <xsl:template match="orderedlist/listitem/para">
    <xsl:text>&#10;. </xsl:text><xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="itemizedlist/listitem/para">
    <xsl:text>&#10;* </xsl:text><xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="orderedlist | itemizedlist">
    <xsl:text>&#10;</xsl:text>
      <xsl:apply-templates/>
    <xsl:text>&#10;</xsl:text>
  </xsl:template>

  <xsl:template match="note|important">
    <xsl:text>&#10;[NOTE]&#10;</xsl:text>
    <xsl:text>.</xsl:text><xsl:value-of select="title"/>
    <xsl:text>&#10;====&#10;</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>&#10;====&#10;</xsl:text>
  </xsl:template>

  <xsl:template match="caution">
    <xsl:text>[CAUTION]&#10;</xsl:text>
    <xsl:text>.</xsl:text><xsl:value-of select="title"/>
    <xsl:text>&#10;====&#10;</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>&#10;====&#10;</xsl:text>
  </xsl:template>

  <xsl:template match="warning">
    <xsl:text>[WARNING]&#10;</xsl:text>
    <xsl:text>.</xsl:text><xsl:value-of select="title"/>
    <xsl:text>&#10;====&#10;</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>&#10;====&#10;</xsl:text>
  </xsl:template>

  <xsl:template match="title">
    <xsl:choose>
      <xsl:when test="parent::note|parent::table|parent::warning|parent::tip|parent::caution|parent::sect5|parent::formalpara">
      </xsl:when>
      <xsl:when test="parent::figure">
	<xsl:text>.</xsl:text><xsl:apply-templates/><xsl:text>&#10;</xsl:text>
      </xsl:when>
      <xsl:otherwise>
	<xsl:apply-templates/><xsl:text>&#10;</xsl:text>
      </xsl:otherwise>
      </xsl:choose>
  </xsl:template>

  <xsl:template match="citation">
    <xsl:text>(</xsl:text><xsl:apply-templates/><xsl:text>)</xsl:text>
  </xsl:template>

  <xsl:template match="footnote/para">
    <xsl:text> footnote:[</xsl:text><xsl:apply-templates/><xsl:text>] </xsl:text>
  </xsl:template>
  
  <xsl:template match="table">
    <xsl:text>&#10;.</xsl:text><xsl:value-of select="title"></xsl:value-of>
    <xsl:text>&#10;|====&#10;</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>&#10;|====&#10;</xsl:text>
  </xsl:template>
  
  <xsl:template match="informaltable">
    <xsl:text>&#10;|====&#10;</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>&#10;|====&#10;</xsl:text>
  </xsl:template>
  
  <xsl:template match="thead">
    <xsl:apply-templates/>
    <xsl:text>&#10;&#10;</xsl:text>
  </xsl:template>

  <xsl:template match="tbody">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="row">
    <xsl:apply-templates/><xsl:text>&#10;</xsl:text>
  </xsl:template>

  <xsl:template match="entry">
    <xsl:text>| </xsl:text>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="formalpara">
    <xsl:text>.</xsl:text><xsl:value-of select="title"/>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="blockquote">
    <xsl:text>[quote,</xsl:text><xsl:value-of select="attribution"/><xsl:text>]&#10;____</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>&#10;____</xsl:text>
  </xsl:template>
  
  <xsl:template match="attribution">
  </xsl:template>

  <xsl:template match="glossentry">
    <xsl:value-of select="glossterm"/><xsl:text>::</xsl:text><xsl:apply-templates select="glossdef"/>
  </xsl:template>

  <xsl:template match="superscript">
    <xsl:text>^</xsl:text><xsl:apply-templates/><xsl:text>^</xsl:text>
  </xsl:template>

  <xsl:template match="subscript">
    <xsl:text>~</xsl:text><xsl:apply-templates/><xsl:text>~</xsl:text>
  </xsl:template>

  <xsl:template match="remark">
    <xsl:text>&#10;[role="remark"]&#10;</xsl:text>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="ulink">
    <xsl:text>link:</xsl:text><xsl:value-of select="@url"/><xsl:text>[</xsl:text><xsl:apply-templates/><xsl:text>]</xsl:text>
  </xsl:template>

  <xsl:template match="link">
    <xsl:text disable-output-escaping="yes">&lt;&lt;</xsl:text><xsl:value-of select="@linkend"/><xsl:text disable-output-escaping="yes">&gt;&gt;</xsl:text>
  </xsl:template>

  <xsl:template match="quote">
    <xsl:text>&#10;[quote]&#10;</xsl:text><xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="programlisting|literallayout|computeroutput">
    <xsl:text>&#10;[source]&#10;----</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>&#10;----</xsl:text>
  </xsl:template>
  
  <xsl:template match="foreignphrase">
    <xsl:text>[foreign]#</xsl:text><xsl:apply-templates/><xsl:text>]</xsl:text>
  </xsl:template>
</xsl:stylesheet>


