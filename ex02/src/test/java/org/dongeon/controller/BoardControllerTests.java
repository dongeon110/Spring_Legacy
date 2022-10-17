package org.dongeon.controller;


import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

@RunWith(SpringJUnit4ClassRunner.class)
// Test for Controller
@WebAppConfiguration // ServletContext를 이용하기 위함. 스프링에선 WebApplicationContext
@ContextConfiguration({
        "file:src/main/webapp/WEB-INF/spring/root-context.xml",
        "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
//Java Config
//@ContextConfiguration(classes = {
//        org.dongeon.config.RootConfig.class,
//        org.dongeon.config.ServletConfig.class})
@Log4j
public class BoardControllerTests {

    @Setter(onMethod_ = {@Autowired})
    private WebApplicationContext ctx;

    private MockMvc mockMvc; // 가짜 mvc

    @Before // 모든 테스트 전에 매번 실행되는 메서드
    public void setup() {
        this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
    }

    @Test
    public void testList() throws Exception {

        log.info(
                mockMvc.perform(MockMvcRequestBuilders.get("/board/list"))
                        .andReturn()
                        .getModelAndView()
                        .getModelMap());
    }

    @Test
    public void testRegister() throws Exception{

        String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/board/register")
                .param("title", "테스트 새글 제목")
                .param("bcontent", "테스트 새글 내용")
                .param("writer", "user00")
        ).andReturn().getModelAndView().getViewName();

        log.info(resultPage);
    }

    @Test
    public void testGet() throws Exception {

        log.info(mockMvc.perform(MockMvcRequestBuilders
                .get("/board/get")
                .param("bno", "2"))
                .andReturn()
                .getModelAndView().getModelMap());
    }

    @Test
    public void testModify() throws Exception {

        String resultPage = mockMvc
                .perform(MockMvcRequestBuilders.post("/board/modify")
                        .param("bno", "1")
                        .param("title", "수정된 테스트 새글 제목")
                        .param("bcontent", "수정된 테스트 새글 내용")
                        .param("writer", "user00"))
                .andReturn().getModelAndView().getViewName();

        log.info(resultPage);
    }

    @Test
    public void testRemove() throws Exception {
        // 삭제전 데이터베이스에 게시물 번호 확인 할 것
        String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/board/remove")
                .param("bno", "25")
                ).andReturn().getModelAndView().getViewName();

        log.info(resultPage);
    }
}
