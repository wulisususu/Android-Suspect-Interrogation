.class public Lio/ionic/starter/BaseApplication;
.super Landroid/app/Application;
.source "BaseApplication.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 10
    invoke-direct {p0}, Landroid/app/Application;-><init>()V

    return-void
.end method


# virtual methods
.method public onCreate()V
    .locals 2

    .line 14
    invoke-super {p0}, Landroid/app/Application;->onCreate()V

    .line 15
    new-instance v0, Lcom/aliyun/emas/apm/ApmOptions$Builder;

    invoke-direct {v0}, Lcom/aliyun/emas/apm/ApmOptions$Builder;-><init>()V

    .line 17
    invoke-virtual {v0, p0}, Lcom/aliyun/emas/apm/ApmOptions$Builder;->setApplication(Landroid/app/Application;)Lcom/aliyun/emas/apm/ApmOptions$Builder;

    move-result-object v0

    const-string v1, "335574661"

    .line 18
    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/ApmOptions$Builder;->setAppKey(Ljava/lang/String;)Lcom/aliyun/emas/apm/ApmOptions$Builder;

    move-result-object v0

    const-string v1, "fdca52bd0bb14439b00f7b1dd2a15480"

    .line 19
    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/ApmOptions$Builder;->setAppSecret(Ljava/lang/String;)Lcom/aliyun/emas/apm/ApmOptions$Builder;

    move-result-object v0

    const-string v1, "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCg4nV461q0VqFq3HwQ67tyW/HgD7iDleFv1efVaND68+dJUYiLMjhawf+jLLux9ElOHqpe36G4XJCmgtgbF2fQH7o4TVH6Y7gu3ltZsMRElJrlquKFX2dyZCujT6CijGOOp2AKjIagVuA/W+cGWpcUF6wOFigfX5S1uYO1s6SezwIDAQAB"

    .line 20
    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/ApmOptions$Builder;->setAppRsaSecret(Ljava/lang/String;)Lcom/aliyun/emas/apm/ApmOptions$Builder;

    move-result-object v0

    const-class v1, Lcom/aliyun/emas/apm/crash/ApmCrashAnalysisComponent;

    .line 22
    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/ApmOptions$Builder;->addComponent(Ljava/lang/Class;)Lcom/aliyun/emas/apm/ApmOptions$Builder;

    move-result-object v0

    const-class v1, Lcom/aliyun/emas/apm/remote/log/ApmRemoteLogComponent;

    .line 24
    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/ApmOptions$Builder;->addComponent(Ljava/lang/Class;)Lcom/aliyun/emas/apm/ApmOptions$Builder;

    move-result-object v0

    const-class v1, Lcom/aliyun/emas/apm/performance/ApmPerformanceComponent;

    .line 26
    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/ApmOptions$Builder;->addComponent(Ljava/lang/Class;)Lcom/aliyun/emas/apm/ApmOptions$Builder;

    move-result-object v0

    const/4 v1, 0x1

    .line 27
    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/ApmOptions$Builder;->openDebug(Z)Lcom/aliyun/emas/apm/ApmOptions$Builder;

    move-result-object v0

    .line 28
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/ApmOptions$Builder;->build()Lcom/aliyun/emas/apm/ApmOptions;

    move-result-object v0

    .line 15
    invoke-static {v0}, Lcom/aliyun/emas/apm/Apm;->preStart(Lcom/aliyun/emas/apm/ApmOptions;)V

    return-void
.end method
