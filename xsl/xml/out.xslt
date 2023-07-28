<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:variable name="totalGlobal">
		<fs>
			<xsl:apply-templates select="//facture"/>
		</fs>
	</xsl:variable>
	
	<xsl:template match="/">
		<facturation>
			<xsl:copy-of select="$totalGlobal/fs/*"/>
		</facturation>
	</xsl:template>
	<xsl:template match="facture">
		<xsl:element name="{translate(name(),'df','DF')}">
			<xsl:apply-templates select="./*"/>
			<stat>
				<xsl:variable name="total" select="sum(.//stotligne)"/>
				<xsl:variable name="countStot" select="count(.//stotligne)"/>
				<total><xsl:value-of select="$total" /></total>
				<nbLigne><xsl:value-of select="$countStot"/></nbLigne>
				<avgLigne><xsl:value-of select="$total div $countStot"/></avgLigne>
			</stat>
		</xsl:element>
	</xsl:template>
	<xsl:template match="*">
		<xsl:copy-of select="."/>
	</xsl:template>
</xsl:stylesheet>
