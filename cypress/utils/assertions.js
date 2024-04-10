class assertions {
	compareInfo(item, compare, value){
		if(compare == 'equal to')
			expect(item).to.equal(value)
		else if (compare == 'not equal')
			expect(item).to.not.equal(value)
		else if (compare == 'greater than')
			expect(item).to.greaterThan(value)
		else if (compare == 'less than')
			expect(item).to.lessThan(value)
		else if (compare == 'equal deep to')
			expect(item).to.deep.equal(value)
	}
}
export default assertions;