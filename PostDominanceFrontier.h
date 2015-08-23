#ifndef POST_DOMINANCE_FRONTIER
#define POST_DOMINANCE_FRONTIER

#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Analysis/DominanceFrontier.h"
#include "llvm/Analysis/PostDominators.h"

namespace llvm {

struct CreateHammockCFG : public FunctionPass {
	static char ID;

	CreateHammockCFG() : FunctionPass(ID) { }

	bool runOnFunction(Function &F) override;

	void getAnalysisUsage(AnalysisUsage &AU) const override {
		AU.addRequired<LoopInfo>();
	}
};

// OPTIMIZE
template <class BlockT>
class PostDominanceFrontierBase : public DominanceFrontierBase<BlockT> {
	public:
		void setRoots(const std::vector<BlockT *> &roots) {
			this->Roots = roots;
		}
};

class PostDominanceFrontier : public FunctionPass {
	PostDominanceFrontierBase<BasicBlock> Base;

	public:
	using DomSetType = DominanceFrontierBase<BasicBlock>::DomSetType;
	using iterator = DominanceFrontierBase<BasicBlock>::iterator;
	using const_iterator = DominanceFrontierBase<BasicBlock>::const_iterator;

	static char ID;

	PostDominanceFrontier();

	iterator begin() {
		return Base.begin();
	}

	const_iterator begin() const {
		return Base.begin();
	}

	iterator end() {
		return Base.end();
	}

	const_iterator end() const {
		return Base.end();
	}

	iterator find(BasicBlock *pBasicBlock) {
		return Base.find(pBasicBlock);
	}

	const_iterator find(BasicBlock *pBasicBlock) const {
		return Base.find(pBasicBlock);
	}

	bool runOnFunction(Function &) override {
		releaseMemory();	// call DominanceFrontierBase.Frontiers.clear()
		PostDominatorTree &postDominatorTree = this->getAnalysis<PostDominatorTree>();
#ifdef CONTROL_DEPENDENCE_GRAPH
		calculate(DT, F);
#else
		Base.setRoots(postDominatorTree.getRoots());


		if (const DomTreeNode *Root = DT.getRootNode()) {
			calculate(DT, Root);
#ifdef PDF_DUMP
			errs() << "=== DUMP:\n";
			dump();
			errs() << "=== EOD\n";
#endif
		}
#endif
		return false;
	}

	void getAnalysisUsage(AnalysisUsage &AU) const override {
		AU.setPreservesAll();
		AU.addRequired<PostDominatorTree>();
	}

	private:
#ifdef CONTROL_DEPENDENCE_GRAPH
	typedef std::pair<DomTreeNode *, DomTreeNode *> Ssubtype;
	typedef std::set<Ssubtype> Stype;

	void calculate(const PostDominatorTree &DT, Function &F);
	void constructS(const PostDominatorTree &DT, Function &F, Stype &S);
	const DomTreeNode *findNearestCommonDominator(const PostDominatorTree &DT,
			DomTreeNode *A, DomTreeNode *B);
#else
	const DomSetType &calculate(const PostDominatorTree &DT,
			const DomTreeNode *Node);
#endif
};

}

#endif
