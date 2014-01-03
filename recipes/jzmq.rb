bash "Install jzmq" do
      code <<-EOH
      cd /tmp
      rm -rf jzmq || true
      git clone --depth 1 https://github.com/nathanmarz/jzmq.git
      cd jzmq
      ./autogen.sh
      ./configure
      touch src/classdist_noinst.stamp
      cd src/
      CLASSPATH=.:./.:$CLASSPATH javac -d . org/zeromq/ZMQ.java org/zeromq/App.java org/zeromq/ZMQForwarder.java org/zeromq/EmbeddedLibraryTools.java org/zeromq/ZMQQueue.java org/zeromq/ZMQStreamer.java org/zeromq/ZMQException.java
      cd ..
      make
      sudo make install
      EOH
        not_if do
                ::File.exists?("/usr/local/lib/libjzmq.so")
                  end
end
