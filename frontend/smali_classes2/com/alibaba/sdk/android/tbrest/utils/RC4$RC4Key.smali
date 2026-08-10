.class Lcom/alibaba/sdk/android/tbrest/utils/RC4$RC4Key;
.super Ljava/lang/Object;
.source "RC4.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/alibaba/sdk/android/tbrest/utils/RC4;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "RC4Key"
.end annotation


# instance fields
.field state:[I

.field x:I

.field y:I


# direct methods
.method private constructor <init>()V
    .locals 1

    .line 84
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/16 v0, 0x100

    new-array v0, v0, [I

    iput-object v0, p0, Lcom/alibaba/sdk/android/tbrest/utils/RC4$RC4Key;->state:[I

    return-void
.end method

.method synthetic constructor <init>(Lcom/alibaba/sdk/android/tbrest/utils/RC4$1;)V
    .locals 0

    .line 84
    invoke-direct {p0}, Lcom/alibaba/sdk/android/tbrest/utils/RC4$RC4Key;-><init>()V

    return-void
.end method
