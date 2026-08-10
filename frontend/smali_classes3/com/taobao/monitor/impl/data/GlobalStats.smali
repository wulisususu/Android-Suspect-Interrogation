.class public Lcom/taobao/monitor/impl/data/GlobalStats;
.super Ljava/lang/Object;
.source "GlobalStats.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/monitor/impl/data/GlobalStats$a;
    }
.end annotation


# static fields
.field public static activityStatusManager:Lcom/taobao/monitor/impl/data/GlobalStats$a; = null

.field public static appAttachBaseContextEndTime:J = -0x1L

.field public static appAttachBaseContextStartTime:J = -0x1L

.field public static appConstructorEndTime:J = -0x1L

.field public static appOnCreateEndTime:J = -0x1L

.field public static appOnCreateStartTime:J = -0x1L

.field public static appVersion:Ljava/lang/String; = "unknown"

.field public static createdPageCount:I = 0x0

.field public static volatile hasSplash:Z = false

.field public static installType:Ljava/lang/String; = "unknown"

.field public static isBackground:Z = false

.field public static isDebug:Z = true

.field public static isFirstInstall:Z = false

.field public static isFirstLaunch:Z = false

.field public static jumpTime:J = -0x1L

.field public static lastProcessStartTime:J = -0x1L

.field public static lastTopActivity:Ljava/lang/String; = ""

.field public static lastValidPage:Ljava/lang/String; = "background"

.field public static lastValidTime:J = -0x1L

.field public static launchStartTime:J = -0x1L

.field public static oppoCPUResource:Ljava/lang/String; = "false"

.field public static processStartTime:J = -0x1L


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 1
    new-instance v0, Lcom/taobao/monitor/impl/data/GlobalStats$a;

    invoke-direct {v0}, Lcom/taobao/monitor/impl/data/GlobalStats$a;-><init>()V

    sput-object v0, Lcom/taobao/monitor/impl/data/GlobalStats;->activityStatusManager:Lcom/taobao/monitor/impl/data/GlobalStats$a;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
