.class Lcom/taobao/monitor/adapter/SimpleApmInitiator$2$4;
.super Ljava/lang/Object;
.source "SimpleApmInitiator.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/taobao/monitor/adapter/SimpleApmInitiator$2;->setMainBiz(Ljava/lang/String;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/taobao/monitor/adapter/SimpleApmInitiator$2;

.field final synthetic val$bizCode:Ljava/lang/String;

.field final synthetic val$bizID:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/taobao/monitor/adapter/SimpleApmInitiator$2;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8010,
            0x1010,
            0x1010
        }
        names = {
            "this$1",
            "val$bizID",
            "val$bizCode"
        }
    .end annotation

    iput-object p1, p0, Lcom/taobao/monitor/adapter/SimpleApmInitiator$2$4;->this$1:Lcom/taobao/monitor/adapter/SimpleApmInitiator$2;

    iput-object p2, p0, Lcom/taobao/monitor/adapter/SimpleApmInitiator$2$4;->val$bizID:Ljava/lang/String;

    iput-object p3, p0, Lcom/taobao/monitor/adapter/SimpleApmInitiator$2$4;->val$bizCode:Ljava/lang/String;

    .line 167
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .line 170
    invoke-static {}, Lcom/taobao/monitor/adapter/DataHubProcedureGroupHelper;->getCurrentProcedures()Lcom/taobao/monitor/procedure/IProcedure;

    move-result-object v0

    if-eqz v0, :cond_0

    const-string v1, "bizID"

    iget-object v2, p0, Lcom/taobao/monitor/adapter/SimpleApmInitiator$2$4;->val$bizID:Ljava/lang/String;

    .line 172
    invoke-interface {v0, v1, v2}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v1, p0, Lcom/taobao/monitor/adapter/SimpleApmInitiator$2$4;->val$bizCode:Ljava/lang/String;

    .line 173
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_0

    const-string v1, "bizCode"

    iget-object v2, p0, Lcom/taobao/monitor/adapter/SimpleApmInitiator$2$4;->val$bizCode:Ljava/lang/String;

    .line 174
    invoke-interface {v0, v1, v2}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    :cond_0
    return-void
.end method
