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
					.lignes{
						width:90%;margin-left:5%;
						margin-top:25mm;
					}
					.cell-number{text-align:center; font-weight:900;}
				</style>
			</head>
			<body>
				<h1>Liste des factures</h1>
				<ul>
					<xsl:apply-templates select="//facture" mode="sommaire"/>
				</ul>
				<table>
					<xsl:call-template name="calcul-total">
						<xsl:with-param name="soustotaux" select="//stotligne"/>
					</xsl:call-template>
				</table>
				<xsl:apply-templates select="//facture"/>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="facture" mode="sommaire">
		<li><a href="#facture-{@numfacture}"><xsl:value-of select="@type"/> N° <xsl:value-of select="@numfacture"/></a></li>
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
	<xsl:template match="@refdevis">
		<br/>en ref. du devis N°<xsl:value-of select="."/>
	</xsl:template>
	<xsl:template match="lignes">
		<table class="lignes" border="1">
			<tr>
				<th>ref</th>
				<th>designation</th>
				<th>€/unit</th>
				<th>quant</th>
				<th>S-Total</th>
			</tr>
			<xsl:apply-templates select="ligne"/>
			<xsl:call-template name="calcul-total"/>
		</table>
	</xsl:template>
	<xsl:template name="somme-arrondis">
		<xsl:param name="nodes"/>
		<xsl:variable name="temporaryNodes">
			<xsl:for-each select="$nodes">
				<value>
					<xsl:value-of select="format-number(.,'0.00')"/>
				</value>
			</xsl:for-each>
		</xsl:variable>
		<xsl:value-of select="sum($temporaryNodes/*)"/>
	</xsl:template>
	<xsl:template name="calcul-total">
		<xsl:param name="soustotaux" select=".//stotligne"/>
		<xsl:variable name="sumRounded">
			<xsl:call-template name="somme-arrondis">
				<xsl:with-param name="nodes" select="$soustotaux"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="ht" select="format-number($sumRounded,'0.00')"/>
		<xsl:variable name="tva" select="format-number($ht*0.2,'0.00')"/>
		<tr>
			<th colspan="2">&#160;</th>
			<th colspan="2">Total HT</th>
			<th>
				<xsl:value-of select="format-number($ht,'0,00€','eurosAndCents')"/>
			</th>
		</tr>
		<tr>
			<th colspan="2">&#160;</th>
			<th colspan="2">TVA</th>
			<th>
				<xsl:value-of select="format-number($tva,'0,00€','eurosAndCents')"/>
			</th>
		</tr>
		<tr>
			<th colspan="2">&#160;</th>
			<th colspan="2">Total TTC</th>
			<th>
				<xsl:value-of select="format-number($ht+$tva,'0,00€','eurosAndCents')"/>
			</th>
		</tr>
	</xsl:template>
	<xsl:template match="ligne">
		<tr class="ligne">
			<xsl:apply-templates select="*"/>
		</tr>
	</xsl:template>
	<xsl:template match="ligne/*"/>
	<xsl:template match="ligne/ref | ligne/designation | ligne/nbUnit">
		<td>
			<xsl:value-of select="."/>
		</td>
	</xsl:template>
	<xsl:decimal-format name="eurosAndCents" decimal-separator="," grouping-separator=" "/>
	<xsl:template match="ligne/stotligne|ligne/phtByUnit">
		<td class="cell-number">
			<xsl:value-of select="format-number(.,'0,00€','eurosAndCents')"/>
		</td>
	</xsl:template>
</xsl:stylesheet>
