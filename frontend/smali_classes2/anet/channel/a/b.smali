.class public Lanet/channel/a/b;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Lanet/channel/flow/INetworkAnalysis;


# instance fields
.field private a:Z


# direct methods
.method public constructor <init>()V
    .locals 4

    .line 15
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    :try_start_0
    const-string v0, "com.taobao.analysis.FlowCenter"

    .line 17
    invoke-static {v0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    const/4 v0, 0x1

    iput-boolean v0, p0, Lanet/channel/a/b;->a:Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    const/4 v0, 0x0

    iput-boolean v0, p0, Lanet/channel/a/b;->a:Z

    const/4 v1, 0x0

    new-array v0, v0, [Ljava/lang/Object;

    const-string v2, "DefaultNetworkAnalysis"

    const-string v3, "no NWNetworkAnalysisSDK sdk"

    .line 21
    invoke-static {v2, v3, v1, v0}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :goto_0
    return-void
.end method


# virtual methods
.method public commitFlow(Lanet/channel/flow/FlowStat;)V
    .locals 10

    iget-boolean v0, p0, Lanet/channel/a/b;->a:Z

    if-eqz v0, :cond_0

    .line 27
    invoke-static {}, Lcom/taobao/analysis/FlowCenter;->getInstance()Lcom/taobao/analysis/FlowCenter;

    move-result-object v1

    invoke-static {}, Lanet/channel/GlobalAppRuntimeInfo;->getContext()Landroid/content/Context;

    move-result-object v2

    iget-object v3, p1, Lanet/channel/flow/FlowStat;->refer:Ljava/lang/String;

    iget-object v4, p1, Lanet/channel/flow/FlowStat;->protocoltype:Ljava/lang/String;

    iget-object v5, p1, Lanet/channel/flow/FlowStat;->req_identifier:Ljava/lang/String;

    iget-wide v6, p1, Lanet/channel/flow/FlowStat;->upstream:J

    iget-wide v8, p1, Lanet/channel/flow/FlowStat;->downstream:J

    invoke-virtual/range {v1 .. v9}, Lcom/taobao/analysis/FlowCenter;->commitFlow(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;JJ)V

    :cond_0
    return-void
.end method
