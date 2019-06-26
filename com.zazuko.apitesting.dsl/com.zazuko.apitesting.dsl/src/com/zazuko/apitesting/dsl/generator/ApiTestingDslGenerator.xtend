/*
 * generated by Xtext 2.17.0
 */
package com.zazuko.apitesting.dsl.generator

import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.AbstractGenerator
import org.eclipse.xtext.generator.IFileSystemAccess2
import org.eclipse.xtext.generator.IGeneratorContext
import com.zazuko.apitesting.dsl.apiTestingDsl.ClassBlock
import com.zazuko.apitesting.dsl.apiTestingDsl.PropertyAssertion
import com.zazuko.apitesting.dsl.apiTestingDsl.ClassLevelAssertion

/**
 * Generates code from your model files on save.
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#code-generation
 */
class ApiTestingDslGenerator extends AbstractGenerator {

	override void doGenerate(Resource resource, IFileSystemAccess2 fsa, IGeneratorContext context) {
		
		val Iterable<ClassBlock> blocks = resource.allContents.filter(ClassBlock).toList
		
		if ( ! blocks.empty) {
			val String dslFileName = resource.getURI().lastSegment.toString();
			val String outFileBase = dslFileName.substring(0, dslFileName.lastIndexOf("."));
			
			fsa.generateFile(outFileBase + '.json', generateSteps(blocks));
		}		
	}	
	
	def generateSteps(Iterable<ClassBlock> blocks) '''
		{
			"steps": [
				«FOR block:blocks SEPARATOR ","»
					«block.step»
				«ENDFOR»
			]
		}
	'''
	
	def step(ClassBlock it) '''
		{
			"type": "Class",
			"classId": "«name»",
			"children": [
				«FOR assertion:assertions SEPARATOR ","»
					«assertion.child»
				«ENDFOR»
			]
		}
	'''	
	
	def dispatch CharSequence child(PropertyAssertion it)  '''
		{
			"type": "Property",
			"propertyId": "«name»",
			"children": [
				«FOR assertion:assertions SEPARATOR ","»
					«assertion.child»
				«ENDFOR»
			]
		}
	'''

	def dispatch child(ClassLevelAssertion it) '''
		# TODO: implementation missing for child(«class.name»)
	'''
	
}
