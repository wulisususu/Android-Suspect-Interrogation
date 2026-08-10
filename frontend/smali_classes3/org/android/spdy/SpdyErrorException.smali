.class public Lorg/android/spdy/SpdyErrorException;
.super Ljava/lang/RuntimeException;
.source "SpdyErrorException.java"


# static fields
.field private static final serialVersionUID:J = 0x3d6141bad21a9e4dL


# instance fields
.field private error:I


# direct methods
.method public constructor <init>(I)V
    .locals 0

    .line 17
    invoke-direct {p0}, Ljava/lang/RuntimeException;-><init>()V

    iput p1, p0, Lorg/android/spdy/SpdyErrorException;->error:I

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;I)V
    .locals 0

    .line 29
    invoke-direct {p0, p1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    iput p2, p0, Lorg/android/spdy/SpdyErrorException;->error:I

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/Throwable;I)V
    .locals 0

    .line 43
    invoke-direct {p0, p1, p2}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    iput p3, p0, Lorg/android/spdy/SpdyErrorException;->error:I

    return-void
.end method

.method public constructor <init>(Ljava/lang/Throwable;I)V
    .locals 0

    .line 55
    invoke-direct {p0, p1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    iput p2, p0, Lorg/android/spdy/SpdyErrorException;->error:I

    return-void
.end method


# virtual methods
.method public SpdyErrorGetCode()I
    .locals 1

    iget v0, p0, Lorg/android/spdy/SpdyErrorException;->error:I

    return v0
.end method
