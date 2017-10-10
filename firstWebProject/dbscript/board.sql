-- 댓글 게시판용 db script file
-- board.sql

DROP TABLE BOARD CASCADE CONSTRAINTS;

CREATE TABLE BOARD (
  BOARD_NUM NUMBER, -- 게시글 번호
  BOARD_TITLE VARCHAR2(50), -- 게시글 제목
  BOARD_WRITER VARCHAR2(15), -- 게시글 작성자
  BOARD_CONTENT VARCHAR2(2000), -- 게시글 내용
  BOARD_ORIGINAL_FILENAME VARCHAR2(100), -- 업로드한 원래 파일명
  BOARD_RENAME_FILENAME VARCHAR2(100), -- 업로드한 바뀐 파일명
  BOARD_DATE DATE   DEFAULT SYSDATE, -- 게시글 올린 날짜
  BOARD_READCOUNT NUMBER   DEFAULT 0, -- 조회수
  BOARD_LEVEL NUMBER   DEFAULT 0, -- 글레벨 : 원글-0, 원글의 댓글-1, 댓글의 댓글-2
  BOARD_REF NUMBER, -- 참조원글번호 : 원글일 때는 자기번호, 댓글일때는 원글번호
  BOARD_REPLY_REF NUMBER, -- 참조댓글번호 : 원글일 때는 0, 1이면 자기번호, 레벨이 2이면 참조하는 댓글번호
  BOARD_REPLY_SEQ NUMBER   DEFAULT 0, -- 댓글 순번
  CONSTRAINT PK_BOARD PRIMARY KEY (BOARD_NUM),
  CONSTRAINT FK_BOARD_WR FOREIGN KEY (BOARD_WRITER) 
      REFERENCES MEMBER (MEMBER_ID) ON DELETE SET NULL,
  CONSTRAINT FK_BOARD_REF FOREIGN KEY (BOARD_REF) 
      REFERENCES BOARD (BOARD_NUM) ON DELETE CASCADE,
  CONSTRAINT FK_BOARD_REPLY_REF FOREIGN KEY (BOARD_REPLY_REF)
      REFERENCES BOARD (BOARD_NUM) ON DELETE CASCADE
);

COMMENT ON COLUMN BOARD.BOARD_NUM IS '게시글번호';
COMMENT ON COLUMN BOARD.BOARD_WRITER IS '게시글작성자 아이디';
COMMENT ON COLUMN BOARD.BOARD_TITLE IS '게시글제목';
COMMENT ON COLUMN BOARD.BOARD_CONTENT IS '게시글내용';
COMMENT ON COLUMN BOARD.BOARD_DATE IS '게시글올린날짜';
COMMENT ON COLUMN BOARD.BOARD_ORIGINAL_FILENAME IS '첨부파일원래이름';
COMMENT ON COLUMN BOARD.BOARD_RENAME_FILENAME IS '첨부파일변경이름';
COMMENT ON COLUMN BOARD.BOARD_LEVEL IS '게시글레벨';
COMMENT ON COLUMN BOARD.BOARD_REF IS '참조원글번호';
COMMENT ON COLUMN BOARD.BOARD_REPLY_REF IS '참조댓글번호';
COMMENT ON COLUMN BOARD.BOARD_REPLY_SEQ IS '댓글순번';
COMMENT ON COLUMN BOARD.BOARD_READCOUNT IS '조회수';

INSERT INTO BOARD VALUES (1, '관리자 게시글', 'admin', 
'저희 사이트를 이용해 주셔서 감사합니다. 활발한 정보 교류가 이루어지길 기대합니다.', 
NULL, NULL, SYSDATE, 0, 0, 1, NULL, 0);

INSERT INTO BOARD VALUES (2, 'MVC Model2 패턴이란', 
'user11', '웹 애플리케이션 설계 방식 중 하나입니다.', NULL, NULL,
DEFAULT, DEFAULT, DEFAULT, 2, NULL, DEFAULT);

INSERT INTO BOARD VALUES (3, '설계방식 2', 
'user22', 
'웹 애플리케이션 설계 방식 중 두번째 방식은 각 서블릿 구동 앞에 First Controller 를 두는 것입니다..', 
NULL, NULL,
DEFAULT, DEFAULT, DEFAULT, 3, NULL,  DEFAULT);

INSERT INTO BOARD VALUES (4, '설계방식3', 
'user22', '웹 애플리케이션 설계 방식 중 세번째 방식은 Front Controller 다음에 연결되는 컨트롤러들을 서블릿이 아닌 자바 클래스로 작성해서 
연결하는 방식입니다.', 
NULL, NULL,
DEFAULT, DEFAULT, DEFAULT, 4, NULL, DEFAULT);

INSERT INTO BOARD VALUES (5, 'MVC Model1 패턴', 
'user11', '웹 애플리케이션 설계 방식 중 JSP 파일이 뷰와 컨트롤러 두가지 다를 처리하는 방식입니다.', 
NULL, NULL,
DEFAULT, DEFAULT, DEFAULT, 5, NULL, DEFAULT);

INSERT INTO BOARD VALUES (6, 'JSP란', 
'user22', 'Java Server Page 를 말함', NULL, NULL,
DEFAULT, DEFAULT, DEFAULT, 6, NULL, DEFAULT);

INSERT INTO BOARD VALUES (7, 'Servlet 이란', 
'user11', '서버에서 구동되는 웹 규약이 적용된 Java EE 모듈이 제공하는 서비스 처리용 클래스임.', 
NULL, NULL,
DEFAULT, DEFAULT, DEFAULT, 7, NULL, DEFAULT);

INSERT INTO BOARD VALUES (8, 'JSP Elements 들', 
'admin', 'Derective(지시자) 태그, Decleation(선언) 태그, Scriptlet 태그, Expression 태그, Comment 태그가 있다.', 
NULL, NULL,
DEFAULT, DEFAULT, DEFAULT, 8, NULL, DEFAULT);

INSERT INTO BOARD VALUES (9, 'HTML5', 
'user22', '새로운 웹 표준기술로 모든 디바이스 장치와 브라우저에서 동일하게 작동되는 웹 페이지를 만들기 위한 기술을 제공한다.', 
NULL, NULL,
DEFAULT, DEFAULT, DEFAULT, 9, NULL, DEFAULT);

INSERT INTO BOARD VALUES (10, 'CSS3', 
'user22', '웹 페이지를 꾸미기 위한 스타일시트로 HTML5 버전에 맞추어 속성들이 업그레이드 되었다.', 
NULL, NULL,
DEFAULT, DEFAULT, DEFAULT, 10, NULL, DEFAULT);

INSERT INTO BOARD VALUES (11, 'JavaScript 란', 
'user11', '웹 표준 2.0 에서 새로 추가된 강력한 API 들을 제공한다.', NULL, NULL,
DEFAULT, DEFAULT, DEFAULT, 11, NULL, DEFAULT);

INSERT INTO BOARD VALUES (12, 'jQuery 란', 
'user11', '자바스크립트 오픈 소스 라이브러리의 하나로 html 요소들을 css 선택자를 이용하여 쉽게 선택할 수 있는 기능들을 제공한다..', 
NULL, NULL,
DEFAULT, DEFAULT, DEFAULT, 12, NULL, DEFAULT);

INSERT INTO BOARD VALUES (13, 'ajax 란', 
'user22', 'asynchronos javascript and xml 의 줄임말로 서버의 서블릿과 직접 통신하는 자바스크립트 기술이다.', 
NULL, NULL,
DEFAULT, DEFAULT, DEFAULT, 13, NULL, DEFAULT);

INSERT INTO BOARD VALUES (14, '필터(Filter) 란', 
'user11', '클라이언트 요청한 서비스가 서블릿으로 전달되기 전에 먼저 구동되는 클래스이다.', 
NULL, NULL,
DEFAULT, DEFAULT, DEFAULT, 14, NULL, DEFAULT);

INSERT INTO BOARD VALUES (15, '래파(Wrapper) 란', 
'user22', '필터가 나꿔챈 요청에 대한 데이터 처리를 담당하는 클래스이다.', NULL, NULL,
DEFAULT, DEFAULT, DEFAULT, 15, NULL, DEFAULT);


COMMIT;
