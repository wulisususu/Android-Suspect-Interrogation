.class public Lanet/channel/Session$a;
.super Ljava/lang/Object;
.source "Taobao"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lanet/channel/Session;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "a"
.end annotation


# static fields
.field public static final AUTHING:I = 0x3

.field public static final AUTH_FAIL:I = 0x5

.field public static final AUTH_SUCC:I = 0x4

.field public static final CONNECTED:I = 0x0

.field public static final CONNECTING:I = 0x1

.field public static final CONNETFAIL:I = 0x2

.field public static final DISCONNECTED:I = 0x6

.field public static final DISCONNECTING:I = 0x7

.field static final a:[Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 8

    const-string v0, "CONNECTED"

    const-string v1, "CONNECTING"

    const-string v2, "CONNETFAIL"

    const-string v3, "AUTHING"

    const-string v4, "AUTH_SUCC"

    const-string v5, "AUTH_FAIL"

    const-string v6, "DISCONNECTED"

    const-string v7, "DISCONNECTING"

    .line 89
    filled-new-array/range {v0 .. v7}, [Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lanet/channel/Session$a;->a:[Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 80
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static a(I)Ljava/lang/String;
    .locals 1

    sget-object v0, Lanet/channel/Session$a;->a:[Ljava/lang/String;

    .line 93
    aget-object p0, v0, p0

    return-object p0
.end method
