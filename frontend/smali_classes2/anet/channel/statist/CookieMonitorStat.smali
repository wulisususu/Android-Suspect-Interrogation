.class public Lanet/channel/statist/CookieMonitorStat;
.super Lanet/channel/statist/StatObject;
.source "Taobao"


# annotations
.annotation runtime Lanet/channel/statist/Monitor;
    module = "networkPrefer"
    monitorPoint = "cookieMonitor"
.end annotation


# instance fields
.field public cookieName:Ljava/lang/String;
    .annotation runtime Lanet/channel/statist/Dimension;
    .end annotation
.end field

.field public cookieText:Ljava/lang/String;
    .annotation runtime Lanet/channel/statist/Dimension;
    .end annotation
.end field

.field public missType:I
    .annotation runtime Lanet/channel/statist/Dimension;
    .end annotation
.end field

.field public setCookie:Ljava/lang/String;
    .annotation runtime Lanet/channel/statist/Dimension;
    .end annotation
.end field

.field public url:Ljava/lang/String;
    .annotation runtime Lanet/channel/statist/Dimension;
    .end annotation
.end field


# direct methods
.method public constructor <init>(Ljava/lang/String;)V
    .locals 0

    .line 15
    invoke-direct {p0}, Lanet/channel/statist/StatObject;-><init>()V

    iput-object p1, p0, Lanet/channel/statist/CookieMonitorStat;->url:Ljava/lang/String;

    return-void
.end method
