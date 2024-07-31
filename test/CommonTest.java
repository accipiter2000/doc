import java.io.InputStream;
import java.util.LinkedList;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.opendynamic.OdUtils;
import com.opendynamic.ff.service.FfService;

import name.fraser.neil.plaintext.diff_match_patch;
import name.fraser.neil.plaintext.diff_match_patch.Diff;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:applicationContext.xml")
public class CommonTest {
    @Autowired
    private FfService ffService;

    @Test
    public void deployProcDef() throws Exception {
        InputStream inputStream;
        // inputStream = this.getClass().getResource("/procdef/simpleDemo.json").openStream();
        // inputStream = this.getClass().getResource("/procdef/nestStageDemo.json").openStream();
        inputStream = this.getClass().getResource("/procdef/nestSubProcDemo.json").openStream();
        // inputStream = this.getClass().getResource("/procdef/subProcDemo3.json").openStream();

        String procDef = OdUtils.inputStreamToString(inputStream);
        inputStream.close();

        String procDefId = OdUtils.getUuid();
        ffService.deployProcDef(procDefId, procDef, null, null, 0, null, null);
        System.out.println(procDefId);
    }

    @Test
    public void diff() {
        String str1 = "66108d36cf06408b9d94d670cfdb5ec4";
        String str2 = "6623109d36cf06408b9d94d670cfdb5ec4";

        LinkedList<Diff> diff_main = new diff_match_patch().diff_main(str1, str2);
        System.out.println(diff_main);
    }
}