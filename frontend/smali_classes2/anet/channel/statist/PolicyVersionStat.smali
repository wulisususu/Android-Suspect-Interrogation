.class public Lanet/channel/statist/PolicyVersionStat;
.super Lanet/channel/statist/StatObject;
.source "Taobao"


# annotations
.annotation runtime Lanet/channel/statist/Monitor;
    module = "networkPrefer"
    monitorPoint = "policyVersion"
.end annotation


# instance fields
.field public host:Ljava/lang/String;
    .annotation runtime Lanet/channel/statist/Dimension;
    .end annotation
.end field

.field public mnc:Ljava/lang/String;
    .annotation runtime Lanet/channel/statist/Dimension;
    .end annotation
.end field

.field public netType:Ljava/lang/String;
    .annotation runtime Lanet/channel/statist/Dimension;
    .end annotation
.end field

.field public reportType:I
    .annotation runtime Lanet/channel/statist/Dimension;
    .end annotation
.end field

.field public version:I
    .annotation runtime Lanet/channel/statist/Dimension;
    .end annotation
.end field


# direct methods
.method public constructor <init>(Ljava/lang/String;I)V
    .locals 0

    .line 23
    invoke-direct {p0}, Lanet/channel/statist/StatObject;-><init>()V

    iput-object p1, p0, Lanet/channel/statist/PolicyVersionStat;->host:Ljava/lang/String;

    iput p2, p0, Lanet/channel/statist/PolicyVersionStat;->version:I

    .line 26
    invoke-static {}, Lanet/channel/status/NetworkStatusHelper;->getNetworkSubType()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lanet/channel/statist/PolicyVersionStat;->netType:Ljava/lang/String;

    .line 27
    invoke-static {}, Lanet/channel/status/NetworkStatusHelper;->getSimOp()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lanet/channel/statist/PolicyVersionStat;->mnc:Ljava/lang/String;

    return-void
.end method
