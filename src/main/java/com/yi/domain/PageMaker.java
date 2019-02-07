package com.yi.domain;

public class PageMaker {//��������ȣ�� �������
	private int totalCount;//�Խù� ��ü����
	private int startPage;//���� ���̴� ������ ���� ��ȣ
	private int endPage; //���� ���̴� ������ �� ��ȣ
	private boolean prev;//���� 10�� ���翩��
	private boolean next;//���� 10�� ���翩��

	private int displayPageNum = 10;//ȭ�鿡 ���̴� ���������� ����
	
	private Criteria cri;
	
	private void calcData() {
		//ex)�Խù��� �� 151�� �ִٴ� �����Ͽ�
		//page��ȣ 15�� ����
		
		//������������ ����ȣ�� ���Ѵ�. ex) 15 / 10 => Math.ceil(1.5) -> 2 * 10 -> 20
		endPage = (int)(Math.ceil(cri.getPage()/(double)displayPageNum) * displayPageNum);
		
		//������������ ���� ��ȣ�� ���Ѵ�. ex)20-10+1 = 11
		startPage = (endPage - displayPageNum)+1;
		
		//cri.getPaerPageNum() : ���������� ������ �Խù� ����
		//��ü �Խù��� 151�̰� ������������ 15�϶�, ������ endPage�� 16�� ��Ÿ�����Ѵ�.
		//ex)Math.ceil(151/10) = 16
		int tempEndPage = (int)(Math.ceil(totalCount/(double)cri.getPerPageNum()));
		
		//���� �������� ��ȣ (endPage)�� ���� ������ �� ��ȣ(tempEndPage)���� ũ�ٸ� �������ش�.
		if(endPage > tempEndPage) {
			endPage = tempEndPage;
		}
		//������������ȣ
		prev = (startPage == 1)? false:true;
		//������������ȣ
		next = (endPage * cri.getPerPageNum()>=totalCount)?false:true;

	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		calcData();//�Լ�ȣ��, �� �Լ��� �� �ʿ��� ���� totalCount�� ���⼭ ȣ��
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	public int getDisplayPageNum() {
		return displayPageNum;
	}

	public void setDisplayPageNum(int displayPageNum) {
		this.displayPageNum = displayPageNum;
	}

	public Criteria getCri() {
		return cri;
	}

	public void setCri(Criteria cri) {
		this.cri = cri;
	}
	
	
}
