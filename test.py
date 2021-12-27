
try:
    import example_module
except:
    Exception(ImportError, "Could not import 'example_module'")