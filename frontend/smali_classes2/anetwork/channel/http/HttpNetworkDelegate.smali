.class public Lanetwork/channel/http/HttpNetworkDelegate;
.super Lanetwork/channel/unified/UnifiedNetworkDelegate;
.source "Taobao"


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    .line 9
    invoke-direct {p0, p1}, Lanetwork/channel/unified/UnifiedNetworkDelegate;-><init>(Landroid/content/Context;)V

    const/4 p1, 0x0

    .line 10
    iput p1, p0, Lanetwork/channel/http/HttpNetworkDelegate;->type:I

    return-void
.end method
