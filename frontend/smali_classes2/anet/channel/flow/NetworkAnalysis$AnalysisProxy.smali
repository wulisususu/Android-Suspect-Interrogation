.class Lanet/channel/flow/NetworkAnalysis$AnalysisProxy;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Lanet/channel/flow/INetworkAnalysis;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lanet/channel/flow/NetworkAnalysis;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "AnalysisProxy"
.end annotation


# instance fields
.field private networkAnalysis:Lanet/channel/flow/INetworkAnalysis;


# direct methods
.method constructor <init>(Lanet/channel/flow/INetworkAnalysis;)V
    .locals 0

    .line 19
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lanet/channel/flow/NetworkAnalysis$AnalysisProxy;->networkAnalysis:Lanet/channel/flow/INetworkAnalysis;

    return-void
.end method


# virtual methods
.method public commitFlow(Lanet/channel/flow/FlowStat;)V
    .locals 1

    iget-object v0, p0, Lanet/channel/flow/NetworkAnalysis$AnalysisProxy;->networkAnalysis:Lanet/channel/flow/INetworkAnalysis;

    if-eqz v0, :cond_0

    .line 26
    invoke-interface {v0, p1}, Lanet/channel/flow/INetworkAnalysis;->commitFlow(Lanet/channel/flow/FlowStat;)V

    :cond_0
    return-void
.end method
