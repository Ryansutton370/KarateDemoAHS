package testRunner;

import com.intuit.karate.junit5.Karate;
import org.junit.runner.RunWith;
import com.intuit.karate.KarateOptions;

@RunWith(Karate.class)
@KarateOptions(features = "classpath:FeatureFiles")
public class TestRunner {

}