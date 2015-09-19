#include <memory>

#include <llvm/IR/Module.h>
#include <llvm/IRReader/IRReader.h>
#include <llvm/Support/SourceMgr.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/Support/raw_ostream.h>
#include <llvm/PassManager.h>

int main(int argc, char **argv) {
	if (argc < 2) {
		llvm::errs() << "Too few arguments.\n";
		return 1;
	}

	llvm::SMDiagnostic diagnostic;
	llvm::LLVMContext context;
	std::unique_ptr<llvm::Module> pmodule = llvm::parseIRFile(argv[1], diagnostic, context);
	if (nullptr == pmodule) {
		diagnostic.print(argv[0], llvm::errs());
		return 1;
	}

	llvm::PassManager passManager;
	// passManager.add(new KleererPass());
	// passManager.run(*pmodule);

	return 0;
}
