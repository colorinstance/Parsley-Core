/*
 * Copyright 2009 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.spicefactory.parsley.object {

import org.spicefactory.parsley.config.NestedConfigurationElement;
import org.spicefactory.parsley.core.builder.ref.ObjectIdReference;
import org.spicefactory.parsley.core.builder.ref.ObjectTypeReference;
import org.spicefactory.parsley.core.errors.ObjectDefinitionBuilderError;
import org.spicefactory.parsley.core.registry.ObjectDefinitionRegistry;

[XmlMapping(elementName="object-ref")]
/**
 * Represents a reference to another object in the container (either by id or by type) in MXML or XML configuration.
 * The <code>idRef</code> and <code>typeRef</code> properties are mutually exclusive.
 * 
 * @author Jens Halm
 */
public class ObjectReferenceTag implements NestedConfigurationElement {
	
	
	/**
	 * The id of the referenced object.
	 */
	public var idRef:String;
	
	/**
	 * The type of the referenced object.
	 */
	public var typeRef:Class;
	
	/**
	 * Indicates whether this instance represents a required dependency.
	 */
	public var required:Boolean = true;
	
	
	/**
	 * @inheritDoc
	 */
	public function resolve (registry:ObjectDefinitionRegistry) : Object {
		if ((idRef != null && typeRef != null) || (idRef == null && typeRef == null)) {
			throw new ObjectDefinitionBuilderError("Exactly one attribute of either id-ref or type-ref must be specified");
		}
		if (idRef != null) {
			return new ObjectIdReference(idRef, required);
		}
		else {
			return new ObjectTypeReference(typeRef, required);
		}
	}
	
	
}
}
