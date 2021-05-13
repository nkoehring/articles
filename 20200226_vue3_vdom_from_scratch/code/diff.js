const currentTree = { tag: 'div', classList: [], children: [
  { tag: 'span', classList: ['big'], children: ['⚂'] }
]}

const newTree = { tag: 'div', classList: [], children: [
  { tag: 'span', classList: [], children: ['rolling...', { tag: 'tt', classList: [], children: ['test'] }] }
]}

function countChildren(node) {
  if (!node || typeof node !== "object") return 0;
  return node.children.filter(c => typeof c === "object").length;
}

function compareChildren(children, oldChildren, index, patches, newPatches) {
  let leftNode = null
  let currentIndex = index

  oldChildren.forEach((oldChild, index) => {
    const child = children[index]
    if (child) {
      currentIndex += countChildren(leftNode) + 1
      compareNodes(child, oldChild, currentIndex, patches)
      leftNode = oldChild
    } else {
      newPatches.push({ type: 'remove', index })
    }
  })

  if (children.length > oldChildren.length) {
    let delta = oldChildren.length
    while (delta < children.length) {
      const node = children[delta++]
      newPatches.push({ type: 'insert', node })
    }
  }
}

function compareNodes(node, oldNode, index, patches) {
  const newPatches = []
  if (typeof node === 'string' && typeof oldNode === 'string') newPatches.push({type: 'text', node})
  else {
    if (node.tag !== oldNode.tag) {
      newPatches.push({type: 'replace', node})
    }
    if (node.classList.sort().join() !== oldNode.classList.sort().join()) {
      newPatches.push({type: 'classList', value: node.classList})
    }
    compareChildren(node.children, oldNode.children, index, patches, newPatches)
  }

  if (newPatches.length > 0) patches[index] = newPatches
}

function diff(newTree, oldTree) {
  let patches = {}
  compareNodes(newTree, oldTree, 0, patches)
  console.log(JSON.stringify(patches))
}

// console.log('currentTree:')
// console.log(JSON.stringify(currentTree))
// 
// console.log('\nnewTree:')
// console.log(JSON.stringify(newTree))
// 
// console.log('\ndiff:')
diff(newTree, currentTree)
