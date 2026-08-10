.class Lcom/taobao/monitor/adapter/device/ApmHardWareInfo$OnlineRenderer;
.super Ljava/lang/Object;
.source "ApmHardWareInfo.java"

# interfaces
.implements Landroid/opengl/GLSurfaceView$Renderer;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "OnlineRenderer"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;


# direct methods
.method constructor <init>(Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8010
        }
        names = {
            "this$0"
        }
    .end annotation

    iput-object p1, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo$OnlineRenderer;->this$0:Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;

    .line 307
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onDrawFrame(Ljavax/microedition/khronos/opengles/GL10;)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "arg0"
        }
    .end annotation

    return-void
.end method

.method public onSurfaceChanged(Ljavax/microedition/khronos/opengles/GL10;II)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0,
            0x0
        }
        names = {
            "arg0",
            "arg1",
            "arg2"
        }
    .end annotation

    return-void
.end method

.method public onSurfaceCreated(Ljavax/microedition/khronos/opengles/GL10;Ljavax/microedition/khronos/egl/EGLConfig;)V
    .locals 2
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0
        }
        names = {
            "gl",
            "config"
        }
    .end annotation

    :try_start_0
    iget-object p2, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo$OnlineRenderer;->this$0:Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;

    const/16 v0, 0x1f01

    .line 311
    invoke-interface {p1, v0}, Ljavax/microedition/khronos/opengles/GL10;->glGetString(I)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p2, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mGpuName:Ljava/lang/String;

    iget-object p2, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo$OnlineRenderer;->this$0:Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;

    const/16 v0, 0x1f00

    .line 312
    invoke-interface {p1, v0}, Ljavax/microedition/khronos/opengles/GL10;->glGetString(I)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p2, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mGpuBrand:Ljava/lang/String;

    iget-object p1, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo$OnlineRenderer;->this$0:Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;

    .line 313
    invoke-virtual {p1}, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->getGpuFreq()J

    move-result-wide v0

    iput-wide v0, p1, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mGpuFreq:J

    iget-object p1, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo$OnlineRenderer;->this$0:Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;

    .line 314
    invoke-static {p1}, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->access$000(Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;)Lcom/taobao/monitor/adapter/device/ApmDeviceInfoCallback;

    move-result-object p1

    iget-object p2, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo$OnlineRenderer;->this$0:Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;

    iget-object p2, p2, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mGpuName:Ljava/lang/String;

    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo$OnlineRenderer;->this$0:Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;

    iget-object v0, v0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mGpuBrand:Ljava/lang/String;

    invoke-interface {p1, p2, v0}, Lcom/taobao/monitor/adapter/device/ApmDeviceInfoCallback;->gpuInfo(Ljava/lang/String;Ljava/lang/String;)V

    iget-object p1, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo$OnlineRenderer;->this$0:Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;

    .line 315
    invoke-static {p1}, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->access$100(Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    const-string p2, "GPU_NAME"

    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo$OnlineRenderer;->this$0:Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;

    iget-object v0, v0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mGpuName:Ljava/lang/String;

    invoke-interface {p1, p2, v0}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    iget-object p1, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo$OnlineRenderer;->this$0:Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;

    .line 316
    invoke-static {p1}, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->access$100(Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    const-string p2, "GPU_BRAND"

    iget-object v0, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo$OnlineRenderer;->this$0:Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;

    iget-object v0, v0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->mGpuBrand:Ljava/lang/String;

    invoke-interface {p1, p2, v0}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    iget-object p1, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo$OnlineRenderer;->this$0:Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;

    .line 317
    invoke-static {p1}, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;->access$100(Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences$Editor;->apply()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :catchall_0
    return-void
.end method
