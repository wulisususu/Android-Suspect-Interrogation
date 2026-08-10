.class public final Lanet/channel/entity/c;
.super Ljava/lang/Object;
.source "Taobao"


# static fields
.field public static a:I = 0x1

.field public static b:I = 0x2

.field public static c:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const/4 v0, 0x1

    or-int/lit8 v0, v0, 0x2

    sput v0, Lanet/channel/entity/c;->c:I

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 7
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
