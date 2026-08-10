.class Lcom/taobao/monitor/adapter/device/ApmHardWareInfo$OnlineGLSurfaceView;
.super Landroid/opengl/GLSurfaceView;
.source "ApmHardWareInfo.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "OnlineGLSurfaceView"
.end annotation


# instance fields
.field mRenderer:Lcom/taobao/monitor/adapter/device/ApmHardWareInfo$OnlineRenderer;

.field final synthetic this$0:Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;


# direct methods
.method public constructor <init>(Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;Landroid/content/Context;)V
    .locals 7
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8010,
            0x0
        }
        names = {
            "this$0",
            "context"
        }
    .end annotation

    iput-object p1, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo$OnlineGLSurfaceView;->this$0:Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;

    .line 341
    invoke-direct {p0, p2}, Landroid/opengl/GLSurfaceView;-><init>(Landroid/content/Context;)V

    const/16 v1, 0x8

    const/16 v2, 0x8

    const/16 v3, 0x8

    const/16 v4, 0x8

    const/4 v5, 0x0

    const/4 v6, 0x0

    move-object v0, p0

    .line 342
    invoke-virtual/range {v0 .. v6}, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo$OnlineGLSurfaceView;->setEGLConfigChooser(IIIIII)V

    .line 343
    new-instance p2, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo$OnlineRenderer;

    invoke-direct {p2, p1}, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo$OnlineRenderer;-><init>(Lcom/taobao/monitor/adapter/device/ApmHardWareInfo;)V

    iput-object p2, p0, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo$OnlineGLSurfaceView;->mRenderer:Lcom/taobao/monitor/adapter/device/ApmHardWareInfo$OnlineRenderer;

    .line 344
    invoke-virtual {p0, p2}, Lcom/taobao/monitor/adapter/device/ApmHardWareInfo$OnlineGLSurfaceView;->setRenderer(Landroid/opengl/GLSurfaceView$Renderer;)V

    return-void
.end method
