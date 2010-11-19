(in-package :llvm)

(defcfun (kind "LLVMGetTypeKind") type-kind
  (ty type))

(defcfun (context "LLVMGetTypeContext") context
  (ty type))

(defcfun* "LLVMInt1TypeInContext" type (c context))
(defun int1-type (&key (context (global-context)))
  (int1-type-in-context context))
(defcfun* "LLVMInt8TypeInContext" type (c context))
(defun int8-type (&key (context (global-context)))
  (int8-type-in-context context))
(defcfun* "LLVMInt16TypeInContext" type (c context))
(defun int16-type (&key (context (global-context)))
  (int16-type-in-context context))
(defcfun* "LLVMInt32TypeInContext" type (c context))
(defun int32-type (&key (context (global-context)))
  (int32-type-in-context context))
(defcfun* "LLVMInt64TypeInContext" type (c context))
(defun int64-type (&key (context (global-context)))
  (int64-type-in-context context))
(defcfun* "LLVMIntTypeInContext" type (c context)
  (num-bits :unsigned-int))
(defun int-type (num-bits &key (context (global-context)))
  (int-type-in-context context num-bits))

(defcfun (width "LLVMGetIntTypeWidth") :unsigned-int (integer-ty type))

(defcfun* "LLVMFloatTypeInContext" type (c context))
(defun float-type (&key (context (global-context)))
  (float-type-in-context context))
(defcfun* "LLVMDoubleTypeInContext" type (c context))
(defun double-type (&key (context (global-context)))
  (double-type-in-context context))
(defcfun* "LLVMX86FP80TypeInContext" type (c context))
(defun x86-fp80-type (&key (context (global-context)))
  (x86-fp80-type-in-context context))
(defcfun* "LLVMFP128TypeInContext" type (c context))
(defun fp128-type (&key (context (global-context)))
  (fp128-type-in-context context))
(defcfun (ppc-fp128-type-in-context "LLVMPPCFP128TypeInContext") type
  (c context))
(defun ppc-fp128-type (&key (context (global-context)))
  (ppc-fp128-type-in-context context))

(defcfun (%function-type "LLVMFunctionType") type
  (return-type type)
  (param-types (carray type)) (param-count :unsigned-int)
  (is-var-arg :boolean))
(defun function-type (return-type param-types &key var-arg-p)
  (%function-type return-type param-types (length param-types) var-arg-p))

(defcfun (function-var-arg-p "LLVMIsFunctionVarArg") :boolean
  (function-ty type))
(defcfun (return-type "LLVMGetReturnType") type (function-ty type))
(defcfun* "LLVMCountParamTypes" :unsigned-int (function-ty type))
(defcfun (param-types "LLVMGetParamTypes") :void
  (function-ty type) (dest (:pointer type)))

(defcfun* "LLVMStructTypeInContext" type
  (c context)
  (element-types (carray type)) (element-count :unsigned-int)
  (packed :boolean))
(defun struct-type (element-types packed &key (context (global-context)))
  (struct-type-in-context context element-types (length element-types) packed))
(defcfun* "LLVMCountStructElementTypes" :unsigned-int (struct-ty type))
(defcfun (struct-element-types "LLVMGetStructElementTypes") :void
  (struct-ty type) (dest (:pointer type)))
(defcfun (packed-struct-p "LLVMIsPackedStruct") :boolean (struct-ty type))

(defcfun* "LLVMArrayType" type (element-type type) (element-count :unsigned-int))
(defcfun* "LLVMPointerType" type
  (element-type type) (address-space :unsigned-int))
(defcfun* "LLVMVectorType" type
  (element-type type) (element-count :unsigned-int))

(defcfun (element-type "LLVMGetElementType") type (ty type))
(defcfun (array-length "LLVMGetArrayLength") :unsigned-int (array-ty type))
(defcfun (address-space "LLVMGetPointerAddressSpace") :unsigned-int
  (pointer-ty type))
(defcfun (size "LLVMGetVectorSize") :unsigned-int (vector-ty type))

(defcfun* "LLVMVoidTypeInContext" type (c context))
(defun void-type (&key (context (global-context)))
  (void-type-in-context context))
(defcfun* "LLVMLabelTypeInContext" type (c context))
(defun label-type (&key (context (global-context)))
  (label-type-in-context context))
(defcfun* "LLVMOpaqueTypeInContext" type (c context))
(defun opaque-type (&key (context (global-context)))
  (opaque-type-in-context context))

(defcfun* "LLVMCreateTypeHandle" type-handle (potentially-abstract-ty type))
(defmethod make-instance
           ((class (eql 'type-handle))
            &key (type (error 'required-parameter-error :name 'type)))
  (create-type-handle type))
(defcfun* "LLVMRefineType" :void (abstract-ty type) (concrete-ty type))
(defcfun* "LLVMResolveTypeHandle" :void (type-handle type-handle))
(defcfun* "LLVMDisposeTypeHandle" :void (type-handle type-handle))