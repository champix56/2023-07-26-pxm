<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/">
		<html>
			<head>
				<title/>
				<style type="text/css">
					.facture{
						height:287mm;
						width:200mm; 
						border: 1px solid black;
						page-break-before:always;
					}
					.numfact{
						width:60%;
						margin-left:20%;
						text-align:center;
						margin-top:2cm;
						border: 1px solid black;
					}
				</style>
			</head>
			<body>
				<xsl:apply-templates select="//facture"/>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="facture">
		<div class="facture" id="facture-{@numfacture}">
			<div class="numfact">
				<xsl:choose>
					<xsl:when test="contains(@type,'evis')">Devis</xsl:when>
					<xsl:otherwise>Facture</xsl:otherwise>
				</xsl:choose> N°<xsl:value-of select="@numfacture"/>
				<xsl:apply-templates select="@refdevis"/>
			</div>
			<xsl:apply-templates select="lignes"/>
		</div>
	</xsl:template>
	<xsl:template match="@refdevis"><br/>en ref. du devis N°<xsl:value-of select="."/></xsl:template>
	<xsl:template match="lignes">
		<table class="lignes">
				<tr>
					<th>ref</th><th>designation</th><th>€/unit</th><th>quant</th><th>S-Total</th>
				</tr>
				<xsl:apply-templates select="ligne"/>
		</table>
	</xsl:template>
	<xsl:template match="ligne">
		<tr class="ligne">
			<xsl:apply-templates select="*"/>
		</tr>
	</xsl:template>
	<xsl:template match="ligne/*"/>
	<xsl:template match="ligne/ref | ligne/designation | ligne/nbUnit">
		<td><xsl:value-of select="."/></td>
	</xsl:template>
	<xsl:template match="ligne/stotligne|ligne/phtByUnit">
		<td class="cell-number"><xsl:value-of select="format-number(.,'0,00€')"/></td>
	</xsl:template>
</xsl:stylesheet>
